#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

# Linux (Ubuntu/Debian): install via apt-get when available.
# Ensure curl exists for the fallback installer.
if command -v apt-get >/dev/null 2>&1; then
  apt_update
  apt_install curl

  if apt-cache show starship >/dev/null 2>&1; then
    if apt_install starship; then
      exit 0
    fi
  else
    echo "› starship package not available via apt; falling back to installer script" >&2
  fi
fi

# Fallback: official installer script
if ! command -v starship >/dev/null 2>&1; then
  echo "› Installing starship via installer script" >&2
  curl -fsSL https://starship.rs/install.sh | run_as_root sh -s -- -y
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "starship installation failed" >&2
  exit 1
fi

