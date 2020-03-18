#!/usr/bin/bash

# Setup dotfiles.
../dotfiles.sh

# Install docker containers.
../docker.sh

mkdir -p "$HOME"/{m,c}data/gogs "$HOME"/cdata/gogs/{conf,data} "$HOME"/backup/{gogs,manual-gogs} "$HOME/mdata/torrents"
