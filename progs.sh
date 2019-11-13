#!/bin/bash

[[ ! -d "$HOME/Documents/progs" ]] && mkdir "$HOME/Documents/progs"
cd "$HOME/Documents/progs" || exit 1

if [[ ! -d "$HOME/git/i3blocks-contrib" ]]; then
  cd $HOME/git || exit 1
  git clone https://github.com/vivien/i3blocks-contrib
else
  cd "$HOME/git/i3blocks-contrib" || exit 1
  git pull
fi
