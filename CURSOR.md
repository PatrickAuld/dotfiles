This repo contains the dotfiles for a person setup. It installs and configures several tools for a MacOS machine.

# Layout
All directories contain the install and configuration code for their tool or application.
With the exception of:
* `_util` common utilities used in mutliple tools
* `scripts` are the `install` and `bootstrap` commands to utilize these dotfiles

Files with a `.symlink` postfix are symlinked to the user's home directory.
Configuration is done in `zsh` using predefined filesnaming, see [](./zsh/zshrc.symlink) for details. 

Keep install and management of all tools entirely within their directories.
Ensure all install and configuration is idempotent.
