#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

#[[ ! -h "$XDG_DATA_HOME/Euro Truck Simulator 2" ]] && rm -rf "$XDG_DATA_HOME/Euro Truck Simulator 2"
[[ ! -h "$HOME/Documents/Euro Truck Simulator 2" ]] && rm -rf "$XDG_DATA_HOME/Euro Truck Simulator 2"
#ln -sfv "$SD" "$XDG_DATA_HOME/Euro Truck Simulator 2"
ln -sfv "$SD" "$HOME/Documents/Euro Truck Simulator 2"
