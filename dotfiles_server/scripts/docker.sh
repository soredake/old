#!/usr/bin/bash

## Base containers
main() {
docker run -d \
  --name sshfs \
  --restart always \
  -p 21000:21000 -p 21000:21000/udp \
  -v "$HOME/mdata/torrents:/torrents":ro \
  fdsfgs/ssh:20170326 sh -c "/usr/bin/ssh-keygen -A && exec /usr/sbin/sshd -D -e -p 21000"

docker run -d \
  --name syncthing \
  --restart always \
  --user "$(id -u)":"$(id -g)" \
  -p 22000:22000 -p 21025:21025/udp \
  -v "$HOME/cdata/syncthing:/config" \
  -v "$HOME/mdata/syncthing:/sync" \
  fdsfgsglibc/syncthing:20170326 syncthing -gui-address=0.0.0.0:8384 -no-browser -home="/config"

## rtorrent tmux ssh
read -p "rtorrent-tmux-ssh password? " ppass;
printf "pass=$ppass" > "$HOME/creds.txt"
docker run -dt \
   --restart always \
   -p 21001:21001 -p 21001:21001/udp \
   -v "$HOME/creds.txt":/creds.txt:ro \
   -v "$HOME/mdata/torrents:/downloads" \
   --name rtorrent-tmux-ssh \
   fdsfgs/rtorrent-tmux-ssh:20170326 /bin/s6-svscan /etc/service

## nginx reverse_proxy
read -p "nginx username? " puser;
read -p "nginx password? " ppass;
printf "user=$puser\npass=$ppass" > "$HOME/creds.txt"
# --volumes-from="ttrss-alone"
docker run -dt \
  -p '443:443' \
  --restart always \
  -v "$HOME/mdata/stream":/var/www/f:ro \
  -v "$HOME/creds.txt":/creds.txt:ro \
  --link syncthing \
  --name nginx_reverse_proxy \
  fdsfgs/nginx-rproxy-server:20170226

### gitea
if [[ ! -f "$HOME/cdata/gogs/conf/app.ini" ]]; then
  read -p "Choose domain for gogs certeficates? " gogsdom;
  read -p "Choose domain for gogs certeficates? " gogsseckey;
  cp conf/app.ini "$HOME"/cdata/gogs/conf
  sed -i "s/CHANGEMEDOMAIN/$gogsdom/g" "$HOME/cdata/gogs/conf/app.ini"
  sed -i "s/CHANGEMESECRETKEY/$gogsseckey/g" "$HOME/cdata/gogs/conf/app.ini"
  docker run -it --rm -v "$HOME/cdata/gogs/conf":/certs gogs/gogs sh -c "cd /certs && /app/gogs/gogs cert -ca=true -duration=8760h0m0s -host=$gogsdom"
  gogs
fi
docker run -d -p 10022:22 -p 3000:3000 --name gogs --restart always -v "$HOME/cdata/gogs":/data/gogs -v "$HOME/mdata/gogs":/data/git gogs/gogs:0.9.97

#### rtorrent-rutorrent
if [[ ! -f "$HOME/mdata/torrents/.htpasswd" ]]; then
  read -p "Choose rtorrent-rutorrent username? " rtuser;
  read -p "Choose rtorrent-rutorrent password? " rtpass;
  mkdir "$HOME/mdata/torrents"
  cd "$HOME/mdata/torrents" || exit 1
  printf "$rtuser:$(openssl passwd -apr1 $rtpass)\n" > .htpasswd
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
fi
docker run -dt --name rtorrent-rutorrent --restart always -p 11443:443 -p 49169:49169/udp -p 49168:49168 -e "USR_ID=$(id -u)" -e "GRP_ID=$(id -g)" -v "$HOME/mdata/torrents:/downloads" diameter/rtorrent-rutorrent:stable

docker run -dt \
  --name distccd-amd64 \
  --restart always \
  -p 3632:3632 \
  fdsfgsglibc/distccd-amd64:latest distccd --no-detach --allow 0.0.0.0/0 --user distcc --log-level warning

docker run -dt --restart always \
  --env 'DB_NAME=ttrss' \
  --env 'DB_USER=docker' --env 'DB_PASS=docker' \
  --env 'PG_TRUST_LOCALNET=true' \
  --name pgsql \
  --volume "$HOME/mdata/postgresql":/var/lib/postgresql \
  sameersbn/postgresql:9.4-24

sleep 15
docker run -d --restart always \
  --link pgsql:db \
  --name ttrss \
  -e DB_NAME=ttrss \
  -e DB_USER=docker -e DB_PASS=docker \
  -p 1433:80 \
  clue/ttrss
}

pobochnie() {
docker run --name mysql -d \
  -e 'DB_USER=mysql' -e 'DB_PASS=mysql' -e 'DB_NAME=cytube' \
  sameersbn/mysql:latest

### Taskd
docker run -d --name taskd \
  -e CERT_CN="taskd" \
  -e CERT_COUNTRY="DE" \
  -e CERT_LOCALITY="Munich" \
  -e CERT_ORGANIZATION="some org" \
  -e CERT_STATE="Bavaria" \
  -p 53589:53589 \
  -v "$HOME/mdata/taskd":/var/taskd \
  x4121/taskd:latest
docker exec -it taskd sh <<END
read -p "Username to create? " username
read -p "Group to create? " group
taskd add org $group
taskd add user $group "$username"
cd pki
gosu taskd ./generate.client $username
END

docker run -d --name twister --restart always -p 28332:28332 -v "$HOME"/mdata/twister:/root/.twister miguelfreitas/twister

read -p "Vnc password? " vncpass;
read -p "Vnc port? " vncport;
docker run -d \
  --name qemu0 \
  --device /dev/kvm \
  --privileged \
  --restart always \
  -e VNCMEMORY='400000' \
  -e VNCPASS="$vncpass" \
  -e VNCPORT="$vncport" \
  -p $vncport:$vncport \
  -v "$HOME/cdata/libvirt/winxp0.img":/usr/local/libvirt/winxp0.img \
  gentoo-libvirt

### Yacy
docker run -d \
  --name yacy \
  --restart always \
  -p 10029:8090 \
  -p 10030:8443 \
  -v "$HOME/mdata/yacy":/opt/yacy/DATA \
  fdsfgs/yacy:20170119
docker exec -it yacy bash /opt/yacy/bin/passwd.sh password

docker run -it --rm \
--name svencoop \
--user '1000:1000' \
--net host \
-w /home/steam/Steam \
-p '27015:27015' \
-v "$HOME/steam":/home/steam/Steam/steamapps/common \
fdsfgsglibcmultilib/steamcmd sh -c 'ln -s /opt/steamcmd/{linux32,steamcmd.sh} .
if [ -z $login ]; then login=anonymous; else login=$login; fi
./steamcmd.sh +login $login +app_update 276060
cd steamapps/common/Sven\ Co-op\ Dedicated\ Server/
grep -q "as_command survival_enabled 0" svencoop/server.cfg || echo "as_command survival_enabled 0" >> svencoop/server.cfg
grep -q "pausable \"0\"" svencoop/listenserver.cfg || sed -i "s/pausable.*/pausable \"1\"/g" svencoop/listenserver.cfg
grep -q "sv_region 255" svencoop/server.cfg || sed -i "s/sv_region.*/sv_region -1\./g" svencoop/server.cfg
./svends_run +skill 3 +port 27015 +maxplayers 2 +map th_ep3_00'
}
main
