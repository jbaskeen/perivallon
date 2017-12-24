#!/bin/bash

alias vim="nvim"

alias gs="git status"
alias gc="git checkout"
alias gp="git pull"
alias gpo="git pull origin"
alias gf="git fetch"

alias mk="minikube"
alias k8s="kubectl"

alias chug='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

export SHELLCHECK_OPTS="-e SC2091"
