#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

# Linux (Ubuntu/Debian): install via apt-get when available.
# Ensure curl exists for the fallback installer.
if command -v apt-get >/dev/null 2>&1; then
  if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y curl
    if sudo apt-get install -y starship; then
      exit 0
    fi
  elif [ "$(id -u)" -eq 0 ]; then
    apt-get update
    apt-get install -y curl
    if apt-get install -y starship; then
      exit 0
    fi
  else
    echo "sudo is required to install starship via apt-get; will use fallback if possible." >&2
  fi
fi

# Fallback: official installer script
if ! command -v starship >/dev/null 2>&1; then
  echo "› Installing starship via installer script" >&2
  mkdir -p "$HOME/.local/bin"
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
fi
