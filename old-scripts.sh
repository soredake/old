#!/bin/bash
while read -r char; do echo "$char"; done < test.txt


# проброс gpu
startvm() {
  sudo chmod 777 /dev/kvm
  sudo cpupower frequency-set -g performance
  sudo virsh start win10-old
}

stopvm() {
  sudo virsh stop win10-old
  sudo cpupower frequency-set -g ondemand
}

passtovm() {
  sed -i -e "s/amdgpu//g" -e '/^$/d' "$(realpath /etc/modules-load.d/modules.conf)"
  sudo tee -a /etc/modules-load.d/vfio.conf <<END
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
END
  sudo tee -a /etc/modprobe.d/vfio-pci.conf <<< "options vfio-pci ids=1002:67ff,1002:aae0"
}

backtohost() {
  tee -a /etc/modules-load.d/modules.conf <<< "amdgpu"
  sudo rm -f /etc/modules-load.d/vfio.conf /etc/modprobe.d/vfio-pci.conf
}

# https://gist.github.com/shamil/62935d9b456a6f9877b5
vm-mount-parts() {
  sudo qemu-nbd --connect=/dev/nbd0 /var/lib/libvirt/images/win10.qcow2
  sudo qemu-nbd --connect=/dev/nbd1 /var/lib/libvirt/images/win10-1.qcow2
  sleep 3
  sudo ntfsfix -db /dev/nbd0p4
  sudo ntfsfix -db /dev/nbd1p2
  sudo mount -o uid=1000,gid=1000 /dev/nbd0p4 "$HOME/media/vm-disk-c"
  sudo mount -o uid=1000,gid=1000 /dev/nbd1p2 "$HOME/media/vm-disk-f"
}

vm-unmount-parts() {
  sudo umount "$HOME/media/vm-disk-c"
  sudo umount "$HOME/media/vm-disk-f"
  sudo qemu-nbd --disconnect /dev/nbd0p4
  sudo qemu-nbd --disconnect /dev/nbd1p2
}

alias redshft='redshift -t 6500:5800 -b 1.0:0.9'
alias vm-sound-restart='sudo virsh destroy win10 && systemctl --user restart pulseaudio && systemctl restart libvirtd && sudo virsh start win10'
alias hostsupdateandr='cd $HOME/git/hosts && peth=$(realpath .) && git reset --hard && git pull && python3 updateHostsFile.py --extensions gambling -a && /system/bin/su -c "mount -o remount,rw /system && mv $peth/hosts /etc/hosts && mount -o remount,ro /system"'
alias hostsupdate='cd $HOME/git/hosts && git reset --hard && git pull && python updateHostsFile.py --extensions gambling -a -r'

# docker images | awk '{print $1}' | xargs -L1 docker pull
# docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}'| xargs -L1 docker pull
# docker images | awk '/^REPOSITORY|/ {next} {print $1}' | xargs -n 1 docker pull
# docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
# docker images | awk 'BEGIN {OFS=":";}NR<2 {next}{print $1, $2}' | sed '/<none>:<none>/g' | xargs -L1 docker pull
# docker images | awk 'BEGIN {OFS=":";}NR<2 {next}{print $1, $2}' | xargs -L1 docker pull
# alias dup="docker images | awk 'BEGIN {OFS=":";}NR<2 {next}{print $1, $2}' | xargs -L1 docker pull"
# https://web.archive.org/web/20160320055741/http://blog.stefanxo.com/2014/08/update-all-docker-images-at-once/

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards.
#[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# https://github.com/vimperator/vimperator-labs/pull/636#issuecomment-257948605
Чтобы найти trailing whitespace:
grep -nr " [[:space:]]\$" .

# Minecraft alias to use the ssh tunnel at port 9999
alias minecraft_socks='java -Xmx1024M -Xms512M -DsocksProxyHost=127.0.0.1 -DsocksProxyPort=9999 -cp /usr/share/minecraft/minecraft.jar net.minecraft.LauncherFrame'

# Auto-correct last input. @TODO: This works?
#alias fuck='$(thefuck $(fc -ln -1))'


tar -x < <(lzip -c -d "${DISTDIR}/${P}.tar.lz") || die

docker run -it --rm \
  --name svencoop \
  --net host \
  -v ~/steam:/home/steam/Steam \
  -p 27015:27015 \
  debian:jessie sh -c 'dpkg --add-architecture i386
apt update
apt upgrade
apt install -y lib32gcc1 libssl1.0.0 libssl1.0.0:i386 libcurl3:i386 wget nano bash
useradd --shell /bin/bash -m steam
mkdir /steamcmd
chown -R steam:steam /steamcmd /home/steam/Steam /home/steam
su - steam
cd /steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +login anonymous +app_update 276060
./steamcmd.sh +app_update 276060
cd ~/Steam/steamapps/common/Sven\ Co-op\ Dedicated\ Server/
./svends_run +skill 2 -num_edicts 3072 +port 27015 +maxplayers 2 +map th_ep3_00'

WINEESYNC=1 WINEPREFIX=~/.local/share/lutris/runners/winesteam/prefix64 wine svends.exe +ip 0.0.0.0 +map -sp_campaign_portal -port 27015
wine explorer /desktop=1920x1080 enginegl.exe -width 1280 +exec gaben.cfg
# Preferred editor for local and remote sessions
#if [[ -n "$SSH_CONNECTION" ]]; then
#  export EDITOR='nano'
#fi

# settings for x11/i3
#localectl set-x11-keymap us,ru pc104 qwerty grp:rctrl_toggle
#sudo sed -i -e "\$a exec i3" -e '57,65d' /etc/X11/xinit/xinitrc

echo $(date +%A)',' $(date '+%d-%m-%Y') $(date '+%H:%M:%S')
#command=echo "MEM $(free -m | grep Mem | awk '{print $3+$6}')M/$(free -m | grep Mem | awk '{print $2}')M"
command=mem=$(free -m | grep Mem); echo "MEM $(awk '{print $3+$6}' <<< "$mem")M/$(awk '{print $2}' <<< "$mem")M"

bindsym $mod+d exec --no-startup-id "rofi -drun-show-actions true -show-icons true -terminal kitty -combi-modi window,drun -show combi -modi combi"

bindsym $mod+F11 exec "i3-msg bar mode toggle"
bindsym F12 exec "maim -i $(xdotool getactivewindow) --format png $HOME/sync/main/Screens/$(date +%d.%m.%G-%T).png"
# toogle microphone input
bindsym $mod+o exec "pactl set-source-mute alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo toggle"
# toogle kolonkee/headphones
bindsym $mod+Shift+KP_1 exec "output-change.sh"

# quick switch to kolonkee
#bindsym $mod+KP_3 exec "pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-lineout"
# quick switch to headphones
#bindsym $mod+KP_9 exec "pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones"

#bindsym $mod+KP_4 exec "save-special-server $(xsel -o --logfile $XDG_CACHE_HOME/xsel/xsel.log)"
#bindsym $mod+KP_5 exec "save-special $(xsel -o --logfile $XDG_CACHE_HOME/xsel/xsel.log)"
#bindsym $mod+Shift+KP_7 exec "maim -s $HOME/sync/main/Screens/$(date +%d.%m.%G-%T).png"
# screenshot current active window
bindsym $mod+Shift+KP_7 exec "maim -f png -m 1 $HOME/sync/main/Screens/$(date +%d.%m.%G-%T).png"
bindsym $mod+Shift+KP_3 exec "/home/bausch/bin/scr l"
bindsym $mod+Shift+KP_9 exec "i3lock"

# set rate
# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg#Using_xset
# @TODO: https://askubuntu.com/questions/140255/how-to-override-the-new-limited-keyboard-repeat-rate-limit
# https://askubuntu.com/questions/765738/how-can-i-increase-the-speed-of-the-cursor-in-gnome-terminal
exec --no-startup-id systemctl --user restart nm-applet mouse_accel xsetdpms xautolock xset-kbd-rate
exec --no-startup-id sleep 10 && systemctl --user restart kbdd kdeconnectd
exec --no-startup-id systemctl --user restart compton-nvidia

# set wallpaper
exec_always feh --no-fehbg --bg-scale "$XDG_DATA_HOME/wallpaper-1.jpg"

#for_window [class="^mpv$"] move up
for_window [class="Wine"] floating enable
for_window [class="RPCS3"] floating enable
for_window [title="The Escapists 2"] floating enable
#for_window [class="^plasmawindowed$"] kill
#for_window [class="^Firefox$"] border pixel 1
# https://gist.github.com/lirenlin/9892945

# Minimal windows
new_window pixel 1
new_float pixel 1
#hide_edge_borders both

focus_follows_mouse yes