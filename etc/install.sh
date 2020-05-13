#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# remove if non-link
[[ ! -L /etc/fstab ]] && sudo rm /etc/fstab

for d in $(echo */);
do
  sudo stow $1 -v 2 -d "$SD" -t /etc "$d"
done
