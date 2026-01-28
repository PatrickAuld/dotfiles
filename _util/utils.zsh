#!/usr/bin/env bash

zmodload zsh/datetime

__log(){
  readonly log_file=${log_file:-"/tmp/zsh-startup-$(date +%Y-%m-%d)"}
  echo $1 >> $log_file
}

# __source(filename)
__source(){
  readonly file=${1:?"The file to source must be specified."}
  if [[ -z ${ZSH_RECORD_STARTUP_PROFILE+x} || "${ZSH_RECORD_STARTUP_PROFILE}" -eq 0 ]]; then
    [[ -f "$file" ]] && source "$file"
    return 0
  fi
  local t1=$EPOCHREALTIME
  [[ -f "$file" ]] && source "$file"
  local t2=$EPOCHREALTIME

  local s1=${t1%.*} us1=${t1#*.}
  local s2=${t2%.*} us2=${t2#*.}

  local diff=$(( (s2 - s1) * 1000 + (us2 - us1) ))

  __log "${diff}ms to load $file"
}


