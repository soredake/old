#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

if [[ ! -L "$XDG_DATA_HOME/data/qBittorrent/BT_backup" ]]; then
  rm -f "$XDG_DATA_HOME/data/qBittorrent/BT_backup"
  ln -sv "$SD/qbittorrent/data/qBittorrent/BT_backup" "$XDG_DATA_HOME/data/qBittorrent/BT_backup"
fi

if [[ ! -L "$HOME/.ssh" ]]; then
  rm -f "$HOME/.ssh"
  ln -sv "$SD/ssh" "$HOME/.ssh"
fi