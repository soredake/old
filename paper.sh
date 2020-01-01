#!/bin/bash
# https://wallpaperscraft.com/download/life_is_strange_quest_chloe_price_104041/2560x1080
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1
ln -srfv "$SD/max-and-chloe-life-is-strange-do-2560x1080.jpg" "$XDG_DATA_HOME/wallpaper-1.jpg"
