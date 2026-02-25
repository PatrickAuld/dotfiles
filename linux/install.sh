#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

# Linux (Ubuntu/Debian): install via apt-get when available.

echo "› Linux: installing packages (Ubuntu/Debian)"

if command -v apt-get >/dev/null 2>&1; then
  if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y \
      git \
      zsh \
      curl \
      ripgrep \
      fd-find \
      neovim \
      direnv \
      gh \
      fontconfig \
      fonts-firacode
  elif [ "$(id -u)" -eq 0 ]; then
    apt-get update
    apt-get install -y \
      git \
      zsh \
      curl \
      ripgrep \
      fd-find \
      neovim \
      direnv \
      gh \
      fontconfig \
      fonts-firacode
  else
    echo "sudo is required to install packages via apt-get; skipping." >&2
    echo "Run: sudo linux/install.sh" >&2
  fi
else
  echo "apt-get not found; please install dependencies manually." >&2
fi

# starship is installed via starship/install.sh

