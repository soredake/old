#!/bin/bash
# shellcheck disable=SC2162
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

BS="$SD/backup-system"
BH="$SD/backup-home"

[[ ! -d "$BS" ]] && install -d -m 700 "$BS"
[[ ! -d "$BH" ]] && install -d -m 700 "$BH"

doIt() {
date=$(date +%d.%m.%G-%H.%M.%S)
systemname="$BS/backup-system-$date.tar.zst"
homename="$BH/backup-home-$date.tar.zst"
backupsystem=();
echo -e "\e[1;31mtar'ing system stuff \033[0m"
# https://unix.stackexchange.com/a/400866
tar --create --file "$systemname" --dereference --ignore-failed-read -I 'zstd -19' -v "${backupsystem[@]/#//}"

rpp=$(realpath -- "$0")
backuphome=(
  "${rpp##*$HOME/}"
  # https://github.com/qbittorrent/qBittorrent/wiki/Frequently-Asked-Questions#Where_does_qBittorrent_save_its_settings
  #.local/share/data/qBittorrent/BT_backup
  #.config/qBittorrent
  #.ssh
);
echo -e "\e[1;31mtar'ing home stuff \033[0m"
tar --create --file "$homename" --dereference --ignore-failed-read -I 'zstd -19' -v "${backuphome[@]/#/$HOME/}"

}

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
    doIt;
else
    read -p "Sure to backup? (y/n) ";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
