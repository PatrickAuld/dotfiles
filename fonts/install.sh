#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

if is_linux; then
  # Linux (Ubuntu/Debian): install via apt-get when available.
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    # A solid baseline for terminals/editors.
    sudo apt-get install -y \
      fontconfig \
      fonts-firacode

    # Refresh font cache
    fc-cache -f || true

    exit 0
  fi

  echo "apt-get not found; please install fonts manually." >&2
  exit 0
fi

# macOS / other OS: manual instructions for now

echo "Download Source Code Pro Font:"
echo "https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it"

echo "Download Source Code Pro Nerd Font:"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"

echo "TODO: Automate this"
