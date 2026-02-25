#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

require_linux

echo "› Linux: installing baseline packages (Ubuntu/Debian)"

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y \
    git \
    zsh \
    curl \
    ripgrep \
    fd-find
else
  echo "apt-get not found; please install dependencies manually." >&2
fi
