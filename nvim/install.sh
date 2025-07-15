#!/usr/bin/env bash
set -e

# Install Neovim via Homebrew
if ! command -v nvim &> /dev/null; then
  echo "Installing Neovim via Homebrew"
  brew install neovim
else
  echo "Neovim is already installed"
fi

# Create Neovim config directory if it doesn't exist
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  echo "Creating Neovim config directory"
  mkdir -p "$NVIM_CONFIG_DIR"
fi

echo "Neovim setup complete"
