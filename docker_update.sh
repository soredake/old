#!/bin/bash
docker stop "$(docker ps -a -q)"
docker rm "$(docker ps -a -q)"
docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
"$HOME/git/dotfiles_home/scripts/docker.sh"
