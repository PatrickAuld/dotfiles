# sup yarn
# https://yarnpkg.com

if [[ ! -z "$IN_NIX_SHELL" ]]; then
  return
fi

if (( $+commands[yarn] ))
then
  export PATH="$PATH:`yarn global bin`"
fi
