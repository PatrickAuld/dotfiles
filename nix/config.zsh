# The standard MacOS install doesn't survive restart because of how
# /etc/zshrc is read only. This pulls the Nix binaries onto the 
# path on load to avoid a reinstall.
# https://github.com/NixOS/nix/issues/3616#issuecomment-1495570532

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
