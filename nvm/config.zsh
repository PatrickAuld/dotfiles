# install as defined here: https://github.com/nvm-sh/nvm#install--update-script

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# Lazy load NVM for faster shell startup
_load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Create lazy-loaded wrapper functions for NVM commands
nvm() {
    unset -f nvm node npm npx
    _load_nvm
    nvm "$@"
}

node() {
    unset -f nvm node npm npx
    _load_nvm
    node "$@"
}

npm() {
    unset -f nvm node npm npx
    _load_nvm
    npm "$@"
}

npx() {
    unset -f nvm node npm npx
    _load_nvm
    npx "$@"
}

