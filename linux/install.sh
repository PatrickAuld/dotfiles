#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

# Linux (Ubuntu/Debian): install via apt-get when available.

echo "› Linux: installing packages (Ubuntu/Debian)"

if command -v apt-get >/dev/null 2>&1; then
  apt_update
  packages=(
    git
    zsh
    curl
    ripgrep
    fd-find
    neovim
    direnv
    gh
  )
  if [ "${DOTFILES_HEADLESS:-0}" != 1 ]; then
    packages+=(fontconfig fonts-firacode)
  fi
  apt_install "${packages[@]}"
else
  echo "apt-get not found; please install dependencies manually." >&2
fi

# starship is installed via starship/install.sh


