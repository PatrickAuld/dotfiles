import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class HeadlessTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-headless-")
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name)
        self.repo = self.base / "repo"
        self.home = self.base / "home"
        self.bin = self.base / "bin"
        self.log = self.base / "commands"
        self.home.mkdir()
        self.bin.mkdir()
        paths = [
            "script/bootstrap",
            "script/install",
            "script/util.sh",
            "git/gitconfig.local.symlink.example",
        ]
        paths += [
            str(p.relative_to(ROOT))
            for p in ROOT.glob("*/install.sh")
        ]
        for name in paths:
            target = self.repo / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(ROOT / name, target)
            target.chmod(0o755)
        topic = self.repo / "fixture"
        topic.mkdir()
        (topic / "fixture.symlink").write_text("new config\n")
        (topic / "existing.symlink").write_text("replacement\n")
        (self.home / ".existing").write_text("preserve me\n")
        self.env = dict(
            os.environ,
            HOME=str(self.home),
            PATH=str(self.bin) + ":/usr/bin:/bin",
            MOCK_UID="0",
            MOCK_SUDO_DENIED="0",
            MOCK_APT_FAIL="0",
            MOCK_STARSHIP_AVAILABLE="1",
            TEST_LOG=str(self.log),
            TEST_BIN=str(self.bin),
        )
        for name in [
            "DOTFILES_HEADLESS",
            "DOTFILES_GIT_AUTHORNAME",
            "DOTFILES_GIT_AUTHOREMAIL",
            "GIT_AUTHOR_NAME",
            "GIT_AUTHOR_EMAIL",
        ]:
            self.env.pop(name, None)
        mocks = {
            "uname": 'echo Linux',
            "id": 'echo "$MOCK_UID"',
            "sudo": """
echo "sudo $*" >> "$TEST_LOG"
[ "$1" = -n ] || exit 90
[ "$MOCK_SUDO_DENIED" = 0 ] || exit 1
shift
exec "$@"
""",
            "apt-get": """
[ "$DEBIAN_FRONTEND" = noninteractive ] || exit 91
[ "$NEEDRESTART_MODE" = a ] || exit 92
echo "apt-get $*" >> "$TEST_LOG"
[ "$MOCK_APT_FAIL" = 0 ] || exit 42
""",
            "apt-cache": '[ "$MOCK_STARSHIP_AVAILABLE" = 1 ]',
            "curl": """
echo "curl $*" >> "$TEST_LOG"
case "$*" in
  *starship.rs/install.sh*)
    echo 'printf "#!/bin/sh\\n" > "$TEST_BIN/starship"'
    echo 'chmod +x "$TEST_BIN/starship"'
    ;;
  *nvm-sh*) ;;
  *) exit 93 ;;
esac
""",
            "fc-cache": 'echo "unexpected font cache" >&2; exit 94',
            "open": 'exit 95',
            "brew": 'exit 96',
        }
        for name, body in mocks.items():
            path = self.bin / name
            path.write_text("#!/bin/bash\nset -eu\n" + body + "\n")
            path.chmod(0o755)

    def run_script(self, name, *args):
        return subprocess.run(
            ["/bin/bash", str(self.repo / name), *args],
            env=self.env,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=15,
        )

    def bootstrap(self):
        return self.run_script(
            "script/bootstrap",
            "--headless",
            "--git-name", "Test User",
            "--git-email", "test@example.com",
        )

    def assert_success(self, result):
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_root_bootstrap_and_repeat(self):
        for _ in range(2):
            self.assert_success(self.bootstrap())
        self.assertTrue((self.home / ".fixture").is_symlink())
        self.assertEqual((self.home / ".existing").read_text(), "preserve me\n")
        commands = self.log.read_text()
        self.assertNotIn("sudo ", commands)
        self.assertNotIn("fontconfig", commands)
        self.assertNotIn("fonts-firacode", commands)
        self.assertNotIn("ComicShannsMono", commands)
        self.assertIn("--force-confold", commands)
        self.assertLess(commands.index("apt-get install"), commands.index("curl "))
        self.assertFalse((self.home / ".local/share/fonts").exists())

    def test_nonroot_uses_noninteractive_sudo(self):
        self.env["MOCK_UID"] = "1000"
        self.assert_success(self.run_script("script/install", "--headless"))
        self.assertIn("sudo -n env DEBIAN_FRONTEND=noninteractive", self.log.read_text())

    def test_sudo_denial_is_failure(self):
        self.env.update(MOCK_UID="1000", MOCK_SUDO_DENIED="1")
        result = self.bootstrap()
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("All installed!", result.stdout)
        self.assertNotIn("curl ", self.log.read_text())

    def test_package_failure_is_failure(self):
        self.env["MOCK_APT_FAIL"] = "1"
        result = self.bootstrap()
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("All installed!", result.stdout)

    def test_missing_identity_is_failure(self):
        result = self.run_script("script/bootstrap", "--headless")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("requires --git-name", result.stdout)
        self.assertFalse(self.log.exists())

    def test_font_installer_skips_before_dependencies(self):
        self.env["DOTFILES_HEADLESS"] = "1"
        result = self.run_script("fonts/install.sh")
        self.assert_success(result)
        self.assertIn("Skipping fonts", result.stdout)
        self.assertFalse(self.log.exists())

    def test_starship_fallback_runs_as_root(self):
        self.env.update(DOTFILES_HEADLESS="1", MOCK_STARSHIP_AVAILABLE="0")
        self.assert_success(self.run_script("starship/install.sh"))
        self.assertTrue((self.bin / "starship").exists())
        self.assertNotIn("sudo ", self.log.read_text())

    def test_starship_fallback_uses_noninteractive_sudo(self):
        self.env.update(
            DOTFILES_HEADLESS="1", MOCK_UID="1000", MOCK_STARSHIP_AVAILABLE="0"
        )
        self.assert_success(self.run_script("starship/install.sh"))
        self.assertTrue((self.bin / "starship").exists())
        self.assertIn("sudo -n sh -s -- -y", self.log.read_text())

    def test_desktop_linux_keeps_font_packages(self):
        self.assert_success(self.run_script("linux/install.sh"))
        self.assertIn("fontconfig fonts-firacode", self.log.read_text())

    def test_headless_rejects_macos(self):
        (self.bin / "uname").write_text("#!/bin/sh\necho Darwin\n")
        result = self.run_script("script/install", "--headless")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Linux only", result.stderr)
        self.assertFalse(self.log.exists())


if __name__ == "__main__":
    unittest.main()
