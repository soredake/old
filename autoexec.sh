#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

ln -sfv "$SD/dota2/autoexec.cfg" "/run/media/bausch/Windows 10/SteamLibraryLinux/steamapps/common/dota 2 beta/game/dota/cfg/autoexec.cfg"
#ln -sfv "$SD/portal2/autoexec.cfg" "$HOME/.steam/root/steamapps/common/Portal 2/portal2/cfg/autoexec.cfg"
#ln -sv "$SD/half-life1/autoexec.cfg" "$HOME/.steam/root/steamapps/common/Half-Life/valve/autoexec.cfg"
#ln -sv "$SD/l4d2/autoexec.cfg" "$HOME/.steam/root/steamapps/common/Left 4 Dead 2/left4dead2/cfg/autoexec.cfg"
