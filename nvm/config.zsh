# install as defined here: https://github.com/nvm-sh/nvm#install--update-script

export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm on first use to reduce shell startup time.
__nvm_lazy_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() { __nvm_lazy_load; nvm "$@"; }
node() { __nvm_lazy_load; node "$@"; }
npm() { __nvm_lazy_load; npm "$@"; }
npx() { __nvm_lazy_load; npx "$@"; }

