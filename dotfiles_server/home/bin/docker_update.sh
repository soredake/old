#!/usr/bin/bash

docker stop "$(docker ps -a -q)"
docker rm "$(docker ps -a -q)"
docker images | awk 'BEGIN {OFS=":";}NR<2 {next}{print $1, $2}' | sed '/<none>:<none>/g' | xargs -L1 docker pull
"$HOME/git/dotfiles_server/scripts/docker.sh"
