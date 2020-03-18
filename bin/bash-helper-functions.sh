#!/bin/bash

# write to STDOUT
# info 'message'
info() {
  local message=$1
  echo $message
}

# write to STDERR
# error 'message'
error() {
  local message=$1
  echo $message 1>&2
}

is_rvm_installed() {
  if [ "`type rvm | head -1`" == "rvm is a function" ]
  then
    return 0
  else
    return 1
  fi
}

load_rvm() {

  if [[ -s "$HOME/.rvm/scripts/rvm" ]]
  then
    info 'source rvm in user HOME'
    source $HOME/.rvm/scripts/rvm
  fi

  if [[ -s "/usr/local/rvm/scripts/rvm" ]]
  then
    info 'source rvm in /usr/local'
    source /usr/local/rvm/scripts/rvm
  fi

}
# set the ruby version based on the contents of .ruby-version
set_ruby_version() {
  load_rvm

  rvm use `cat .ruby-version`
}

set_node_version() {
  echo "Installing v.6.9.5 using NVM"
  nvm install v6.9.5
  echo "Installed v.6.9.5 using NVM"
  nvm use v6.9.5
  echo "Now using v.6.9.5 using NVM"
}

# install gems via bundler, first arg is bundler location,
# defaults to ./vendor/bundler if not specified.
bundle_install() {
 local bundler_vendor_path=${1:-vendor/bundler}

 bundle install --no-prune --path $bundler_vendor_path
}
