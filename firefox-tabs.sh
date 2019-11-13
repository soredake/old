#!/bin/bash
list=($(sed "s/ /\n/" "${1}"))
#while read -r char; do char=$(echo "$char" | sed "s/ /\n/") && sleep 2 && echo "$char"; done < "${1}"
# && sleep 2 && echo "$char"
for tab in "${list[@]}"; do sleep 2 && /usr/lib/firefox/firefox "$tab"; done
