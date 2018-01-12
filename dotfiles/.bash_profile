#!/bin/bash

if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ];then
  source $HOME/.bashrc
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
