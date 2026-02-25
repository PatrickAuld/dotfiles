#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

# Linux (Ubuntu/Debian): install via apt-get when available.
# Ensure curl exists for the fallback installer.
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y curl
  if sudo apt-get install -y starship; then
    exit 0
  fi
fi

# Fallback: official installer script
if ! command -v starship >/dev/null 2>&1; then
  echo "› Installing starship via installer script" >&2
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi
