#~/usr/bin/sh

if [[ ! -a ~/.hammerspoon/anycomplete ]]; then
  echo "Installing Hammerspoon anycomplete scripts"
  git clone https://github.com/nathancahill/anycomplete.git ~/.hammerspoon/anycomplete
else
  echo "Skipping installing Hammerspoon anycomplete"
fi

if [[ ! -a ~/.hammerspoon/emojicomplete ]]; then
  echo "Installing Hammerspoon emojicomplete scripts"
  git clone https://github.com/PatrickAuld/emojicomplete.git ~/.hammerspoon/emojicomplete
else
  echo "Skipping installing Hammerspoon emojicomplete"
fi

echo "Opening Hammerspoon App, reload the configs"
open -a /Applications/Hammerspoon.app
