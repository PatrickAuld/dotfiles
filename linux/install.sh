#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

echo "› Linux: installing packages (Ubuntu/Debian)"

if command -v apt-get >/dev/null 2>&1; then
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
else
  echo "apt-get not found; please install dependencies manually." >&2
fi

# starship: try package manager first, otherwise install binary
if ! command -v starship >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    if sudo apt-get install -y starship; then
      true
    else
      echo "› Installing starship via installer script" >&2
      curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    fi
  else
    echo "starship not installed (no apt-get)." >&2
  fi
fi
