#!/usr/bin/env bash

__inNix(){
  [[ -z ${IN_NIX_SHELL} ]]
  return
}

__log(){
  readonly log_file=${log_file:-"/tmp/zsh-startup-$(date +%Y-%m-%d)"}
  echo $1 >> $log_file
}

# __source(filename)
__source(){
  readonly file=${1:?"The file to source must be specified."}
  start=$(date +%s)
  source $file
  finish=$(date +%s)
  __log "$(($finish - $start)) sec to load $file"
}


