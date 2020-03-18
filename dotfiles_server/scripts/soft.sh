#!/usr/bin/bash
mkdir "$HOME/git"
git clone --depth=1 https://gitgud.io/soredake/docker-gc -b fix-shasum "$HOME/git/docker-gc"
ln -sfv "$HOME/git/docker-gc/docker-gc" "$HOME/bin"
