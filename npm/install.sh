#!/usr/bin/env bash

set -euo pipefail

# Create the directories used by npm when configured with a user-local prefix.
mkdir -p "$HOME/.npm/bin" "$HOME/.npm/lib" "$HOME/.npm/share"
