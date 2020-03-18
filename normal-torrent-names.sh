#!/bin/bash

dtf="/media/disk0/torrents"
tn="/media/disk0/torrents-normal"
[[ ! -d "$tn" ]] && mkdir "$tn"

# жизнь с луи сезон 3
ln -sfv "${dtf}/LwL[torrents.ru]" "${tn}/Жизнь с луи (3 сезон)"