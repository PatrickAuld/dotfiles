#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"

if is_darwin; then
  install_dir="$HOME/Library/Fonts"
elif is_linux; then
  install_dir="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y fontconfig curl unzip
  fi
else
  echo "Skipping fonts on unsupported OS: $(os_name)"
  exit 0
fi

for dependency in curl unzip; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    echo "$dependency is required to install fonts." >&2
    exit 1
  fi
done

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

echo "› Installing ComicShannsMono Nerd Font"
comic_dir="$install_dir/comic-shanns-mono"
comic_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/ComicShannsMono.zip"
curl -fsSL "$comic_url" -o "$tmp_dir/ComicShannsMono.zip"
unzip -q -o "$tmp_dir/ComicShannsMono.zip" -d "$tmp_dir/comic-shanns-mono"
mkdir -p "$comic_dir"
find "$tmp_dir/comic-shanns-mono" -type f \( -iname '*.otf' -o -iname '*.ttf' \) -print0 \
  | xargs -0 -I{} cp -f "{}" "$comic_dir/"

if is_linux; then
  echo "› Linux: installing Source Code Pro + Source Code Pro Nerd Font"

  src_dir="$install_dir/source-code-pro"
  nerd_dir="$install_dir/nerd-fonts"

  mkdir -p "$src_dir" "$nerd_dir"

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

  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f || true
  fi
fi
