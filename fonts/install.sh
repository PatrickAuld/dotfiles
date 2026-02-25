#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

if is_linux; then
  # Linux (Ubuntu/Debian): install via apt-get when available.
  if command -v apt-get >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
      sudo apt-get update
      sudo apt-get install -y \
        fontconfig \
        curl \
        unzip
    elif [ "$(id -u)" -eq 0 ]; then
      apt-get update
      apt-get install -y \
        fontconfig \
        curl \
        unzip
    else
      echo "sudo is required to install font dependencies; continuing (may fail if curl/unzip missing)." >&2
    fi
  fi

  echo "› Linux: installing Source Code Pro + Source Code Pro Nerd Font"

  install_dir="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
  src_dir="$install_dir/source-code-pro"
  nerd_dir="$install_dir/nerd-fonts"

  mkdir -p "$src_dir" "$nerd_dir"

  tmp_dir=$(mktemp -d)
  trap 'rm -rf "$tmp_dir"' EXIT

  # Source Code Pro
  # Release page referenced in this repo:
  # https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it
  src_url="https://github.com/adobe-fonts/source-code-pro/releases/download/2.030R-ro%2F1.050R-it/source-code-pro-2.030R-ro-1.050R-it.zip"
  src_zip="$tmp_dir/source-code-pro.zip"
  curl -fsSL "$src_url" -o "$src_zip"
  unzip -q -o "$src_zip" -d "$tmp_dir/source-code-pro"
  find "$tmp_dir/source-code-pro" -type f \( -iname '*.otf' -o -iname '*.ttf' \) -print0 \
    | xargs -0 -I{} cp -f "{}" "$src_dir/"

  # Source Code Pro Nerd Font
  nerd_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"
  nerd_zip="$tmp_dir/SourceCodePro-nerd.zip"
  curl -fsSL "$nerd_url" -o "$nerd_zip"
  unzip -q -o "$nerd_zip" -d "$tmp_dir/nerd"
  find "$tmp_dir/nerd" -type f \( -iname '*.otf' -o -iname '*.ttf' \) -print0 \
    | xargs -0 -I{} cp -f "{}" "$nerd_dir/"

  # Refresh font cache
  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f || true
  fi

  exit 0
fi

# macOS / other OS: manual instructions for now

echo "Download Source Code Pro Font:"
echo "https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it"

echo "Download Source Code Pro Nerd Font:"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"

echo "TODO: Automate this"
