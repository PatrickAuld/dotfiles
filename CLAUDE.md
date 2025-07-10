# CLAUDE.md - Development Context

This is Patrick's personal dotfiles repository for macOS and Linux system configuration.

## Repository Structure

### Key Scripts
- `script/bootstrap` - Main setup script that symlinks dotfiles, sets macOS defaults, and installs dependencies
- `script/install` - Runs all topic-specific install.sh scripts

### Topic-Based Organization
Each directory represents a topic area (e.g., git, zsh, vim, etc.):

**Active Topics:**
- `aws/` - AWS CLI configuration
- `bin/` - Executable scripts added to PATH
- `direnv/` - Directory environment management
- `docker/` - Docker configuration
- `fonts/` - Font installation
- `functions/` - Shell functions
- `fzf/` - Fuzzy finder configuration
- `git/` - Git configuration and aliases
- `hammerspoon/` - Hammerspoon automation (macOS)
- `homebrew/` - Homebrew package management
- `iterm2/` - iTerm2 terminal configuration
- `linux/` - Linux-specific configurations
- `macos/` - macOS system defaults
- `nix/` - Nix package manager
- `npm/` - Node.js package manager
- `nvm/` - Node Version Manager
- `python/` - Python configuration
- `starship/` - Shell prompt configuration
- `system/` - System-wide configurations
- `tar/` - Archive utilities
- `terraform/` - Infrastructure as Code
- `vim/` - Vim editor configuration
- `yarn/` - Yarn package manager
- `zsh/` - Z shell configuration

### File Conventions
- `*.symlink` - Files that get symlinked to `$HOME` (without .symlink extension)
- `*.zsh` - Files loaded into zsh environment
- `path.zsh` - Loaded first for PATH setup
- `completion.zsh` - Loaded last for autocompletion
- `install.sh` - Topic-specific installation scripts

### Package Management
- **macOS**: Uses Homebrew via `Brewfile`
- **Linux**: Uses apt via `Aptfile`

### Key Symlinked Files
- `.gitconfig` - Git configuration
- `.gitignore` - Global git ignore
- `.vimrc` - Vim configuration  
- `.zshrc` - Zsh configuration
- `.npmrc` - NPM configuration
- `.starship-config.toml` - Prompt configuration

### Hammerspoon Setup
- Uses local Spoons in `hammerspoon/hammerspoon.symlink/Spoons/`
- Includes: LockScreen, anycomplete, emojicomplete spoons
- No longer requires git cloning of spoons (fixed in recent commit)

## Development Notes

### Testing Changes
- Always test with `script/bootstrap` in a clean environment
- Check symlinks are created correctly in `$HOME`
- Verify install.sh scripts run without errors

### Common Tasks
- **Add new tool**: Create topic directory with config files and install.sh
- **Update packages**: Modify Brewfile (macOS) or Aptfile (Linux)
- **Shell modifications**: Update relevant .zsh files
- **Git workflow**: Standard git operations, commits include Claude attribution

### Dependencies
Core packages installed via Homebrew:
- git, zsh, node, npm, yarn
- fzf, direnv, starship
- awscli, go, ffmpeg
- diff-so-fancy, gpg

### Security Notes
- Never commit sensitive information
- Use .gitignore.symlink for global excludes
- Git credentials use osxkeychain on macOS

### Installation Flow
1. `script/bootstrap` - Sets up git config and symlinks
2. macOS defaults via `macos/set-defaults.sh` (macOS only)
3. Homebrew/apt package installation
4. Topic-specific `install.sh` scripts execute
5. Manual configuration as needed

This is a mature dotfiles setup following holman's dotfiles philosophy with topic-based organization.