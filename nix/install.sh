#!/usr/bin/env bash

echo "Installing Nix multi-user..."
sh <(curl -L https://nixos.org/nix/install) --daemon
echo "Nix installed"
