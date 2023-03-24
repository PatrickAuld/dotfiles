# install as defined here: https://github.com/nvm-sh/nvm#install--update-script

if [[ ! -z "$IN_NIX_SHELL" ]]; then
  return
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

