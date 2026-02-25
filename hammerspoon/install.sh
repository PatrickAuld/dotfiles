#!/usr/bin/env bash

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
# shellcheck source=script/util.sh
source "$DOTFILES_ROOT/script/util.sh"
require_darwin


echo "Opening Hammerspoon App, reload the configs"
open -a /Applications/Hammerspoon.app
