#!/bin/bash

docker run -d \
  --name syncthing \
  --restart always \
  --user "$(id -u)":1500 \
  -p 8384:8384 -p 22000:22000 -p 21025:21025/udp \
  -v "$HOME/cdata/syncthing:/home/user/syncthing" \
  -v "$HOME/mdata/syncthing:/home/user/sync" \
  armhf-syncthing syncthing -no-browser -home="/home/user/syncthing"

IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
docker run -d --name pihole \
  --cap-add=NET_ADMIN \
  --restart=always \
  -e DNS1="178.17.170.67#54" \
  -e DNS2="77.81.104.121#54" \
  -e ServerIP="$IP" \
  -p 1446:80 \
  -p 53:53/tcp \
  -p 53:53/udp \
  -v /etc/localtime:/etc/localtime:ro \
  diginc/pi-hole:arm_dev
docker exec -it pihole bash -c 'printf "nameserver 127.0.0.1" > /etc/resolv.conf
cp /etc/pihole/adlists.{default,list}
sed -i "s|hosts/master/hosts|hosts/master/alternates/gambling/hosts|g" /etc/pihole/adlists.list
gh="https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/win"
tee -a /etc/pihole/adlists.list >/dev/null <<END
${gh}10/extra.txt
${gh}10/spy.txt
${gh}10/update.txt
${gh}7/extra.txt
${gh}7/spy.txt
${gh}7/update.txt
${gh}81/extra.txt
${gh}81/spy.txt
${gh}81/update.txt
END
pihole -b r3.mail.ru top-fwz1.mail.ru
pihole updateGravity'
docker exec -it pihole cat /etc/pihole/adlists.list
