#!/bin/bash


#alias build_mainline 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg'
#alias build_staging 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg'
#alias tkgup 'cd $HOME/git/PKGBUILDS; git reset --hard origin/frogging-family; git submodule foreach --recursive git reset --hard origin; git pull'
#alias badlinks 'find . -type l -exec test ! -e {} \; -print'



SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


  #sudo apt update
  #sudo apt upgrad
  #flatpak --user update --noninteractive
  #snap refresh
  #fwupdmgr refresh
  #fwupdmgr update



#alias finddupes 'jdupes -R -Nd1Ap'

# fix wine
#sudo apt-get install winehq-staging=5.7~focal wine-staging=5.7~focal wine-staging-amd64=5.7~focal wine-staging-i386=5.7~focal -V

# one more automation TODO: https://bugs.launchpad.net/ubuntu/+source/software-properties/+bug/1882500 https://bugs.kde.org/show_bug.cgi?id=418577
#sudo sed -i 's|//Unattended-Upgrade::Remove-Unused-Dependencies.*|Unattended-Upgrade::Remove-Unused-Dependencies "true";|g' /etc/apt/apt.conf.d/50unattended-upgrades

# TODO: https://github.com/lutris/lutris/issues/2924
# TODO: https://gitlab.gnome.org/GNOME/gimp/-/issues/1830
# sync kde5 places to gtk3 bookmarks
# https://askubuntu.com/questions/694283/how-do-i-sync-kde-5-places-folder-bookmarks-to-gtk-3
function syncgtkbmarks
  awk -F\" '/<bookmark href=\"file/ {print $2}' < "$HOME/.local/share/user-places.xbel" > "$HOME/.config/gtk-3.0/bookmarks"
  # replace space with %20 to fix bookmarks
  sed -i "s/ /%20/g" "$HOME/.config/gtk-3.0/bookmarks"
end

function mkd
  mkdir -p $argv && cd $argv || exit 1;
end

# Convert currencies; cconv {amount} {from} {to}
function cconv
  #| grep '&#8372;</strong>'
  set result (curl -s "https://exchangerate.guru/$argv[2]/$argv[3]/$argv[1]/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')
  echo "$argv[1] $argv[2] = $result $argv[3]"
end


# 5gb max, stores for 24 hours
function cockfile
  curl --progress-bar -F file=@$argv https://cockfile.com/api.php?d=upload-tool
end

  if string match -q m $argv
    ancient-packages -q
    #fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
    return
  end
  #fd -t f -H -I -e .tar.zst --search-path $HOME/git/PKGBUILDS -x "rm" {}


function j
switch $argv
  case d
    cd $HOME/main/Documents
  case g 
    cd $HOME/git
  case m
    cd /media
  case s
    cd $HOME/main
  case t
    cd /media/disk0/torrents
  case '*'
    echo "No folder defined for this alias."
end
end

# 512mb max, stores for 30+ days
function 0x0
  if string match --regex "http?[s]://.*" $argv[1]
    set prefix "url="
  else
    set prefix "file=@"
  end
  curl -F$prefix$argv https://0x0.st
end

# ukr nalogi
# https://duckduckgo.com/?q=(400+-+165)+*+35%25&ia=calculator
# https://rozetka.com.ua/news-articles-promotions/promotions/261738.html
#function ukr-nalogi
#  if [[ "$1" -ge "151" ]]; then
    #poshlina=$(bc -l <<< "($1 - 150) * 0.10")
#    echo Tax is: $(bc -l <<< "($1 - 100 + $poshlina) * 0.20 + $poshlina") EUR
 # else
#    echo Tax is: $(bc -l <<< "($1 - 100) * 0.20") EUR
#  end
#end

#alias build_all 'build_faudio && build_staging'
#alias build_faudio 'tkgup; cd faudio-git && makepkg -si' # https://github.com/Tk-Glitch/PKGBUILDS/issues/458#issuecomment-575811620 and https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/lib32-faudio#n30
# https://wiki.archlinux.org/index.php/Kexec
alias kernelup 'sudo kexec -l /boot/vmlinuz-linux-tkg-pds-zen --initrd=/boot/initramfs-linux-tkg-pds-zen.img --reuse-cmdline && systemctl kexec'
#alias build_proton 'tkgup; cd wine-tkg-git/proton-tkg && ./proton-tkg.sh'
#alias build_wine 'tkgup; cd wine-tkg-git/wine-tkg-git && makepkg -si'
#alias mountandroidfs 'sshfs -o kernel_cache android:/ /media/android'


# https://www.checkyourmath.com/convert/length/inches_cm.php
function cmtoinch
#  echo $(bc -l <<< "$1 / 2.54")
end
function inchtocm
 # echo $(bc -l <<< "$1 * 2.54")
end

sl() {
  streamlink --player-external-http --player-external-http-port 5555 "$@"
}

strurl() {
  streamlink --stream-url "$@"
}

strurl1() {
  streamlink --stream-url --player-passthrough hls,http,rtmp "$@"
}


# Currency conversions
alias usd='cconv 1 usd uah'
#alias yuzu='gamemoderun yuzu'
#alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
#alias rpcs3='gamemoderun rpcs3'
#alias fixres='xrandr --output HDMI-A-0 --auto'
--setenv=XDG_DATA_HOME="${HOME}/.local/share" --setenv=XDG_CONFIG_HOME="${HOME}/.config" --setenv=XDG_CACHE_HOME="${HOME}/.cache"
--setenv=HISTFILE="${XDG_DATA_HOME}/zsh.history" --setenv=ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

cockfile() {
   if [[ "$1" =~ ^https?://.*$ ]]; then local prefix="curl --fail -L --progress-bar ${1} || exit 1"; else local suffix="${1}"; fi
   # eval or sh -c
   eval "${prefix:-true}" | curl --fail -L --progress-bar -F name="${2:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1 | grep -i '[a-zA-Z0-9]').${1##*.}}" -F file=@"${suffix:--}" https://cockfile.com/api.php?d=upload-tool
}

# https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache
#paccache --cachedir="/var/cache/pacman/aur-pkg" -rv
#paccache --cachedir="/var/cache/pacman/aur-pkg" --uninstalled --keep 0 -rv
#sudo paccache --cachedir="/var/cache/pacman/pkg" -rv
#sudo paccache --cachedir="/var/cache/pacman/pkg" --uninstalled --keep 0 -rv

# https://github.com/kakra/wine-proton/blob/rebase/proton_3.16/README.md#hints-to-32-bit-users-applies-also-to-syswow64
# https://github.com/doitsujin/dxvk/issues/1312#issuecomment-570306019
#sudo sed -i "s/; shm-size-bytes.*/shm-size-bytes=1048576/" /etc/pulse/daemon.conf

# fix distorted/crackling/robotized audio in discord and some games
# https://askubuntu.com/questions/1102738/crackling-static-in-discord-with-default-audio-output-port-pulseaudio
# https://www.reddit.com/r/discordapp/comments/7si7s3/linux_crackling_sound_in_application/
# https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Glitches,_skips_or_crackling
#sudo sed -i "s|load-module module-udev-detect|load-module module-udev-detect tsched=0|g" /etc/pulse/default.pa

# git aliases
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'


# Background with log
bkg() {
  logfile=$(mktemp -t "$(basename $1)"-"$(date +%d.%m.%G-%T)"-XXX.log)
  nohup "$@" &>"$logfile" &
}

# https://www.opennet.ru/tips/1455_linux_kernel_cache.shtml?skip=10 
#alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3'
# https://www.lifewire.com/kubuntu-p2-2202573
#alias restart-plasma="kquitapp5 plasmashell; nohup plasmashell &>/dev/null &"

# ownership and permissions quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'
alias owneruser='chown -R $(id -u):$(id -g) .'

# https://shapeshed.com/zsh-corrupt-history-file/
# https://dev.to/rishibaldawa/fixing-corrupt-zsh-history-4nf4
fix_zsh_history() {
  cd "$XDG_DATA_HOME/zsh"
  mv history history_bad
  strings history_bad > history
  fc -R history
  rm -f history_bad
}

# Calculate actual size of {HD,SS}D; actualsize {size} {gb}[optional, use gigabytes instead of terabytes]
# https://www.sevenforums.com/hardware-devices/23890-hdds-advertized-size-vs-actual-size.html
actualsize() {
  if [[ "$2" == gb ]]; then a="0.9313226"; else a="0.9094947"; fi
  echo 'Actual size is:' "$(bc -l <<< "$1 * $a")"
}

# https://www.pixelstech.net/article/1352825068-Use-rsync-to-delete-mass-files-quickly-in-Linux
# https://unix.stackexchange.com/a/277205
# https://www.slashroot.in/which-is-the-fastest-method-to-delete-files-in-linux
# https://serverfault.com/questions/183821/rm-on-a-directory-with-millions-of-files/328305#328305
# https://github.com/edannenberg/kubler/blob/master/engine/docker/bob-core/portage-git-sync.sh#L12
fastdelete() {
  _tmp=$(mktemp -d /tmp/XXX)
  [[ "$2" = "s" ]] && s=sudo
  eval "${s}" rsync -a --delete "$_tmp"/ "$1" || exit 1
  eval "${s}" rmdir "$1" "$_tmp"
}

function backup
  #echo "===Moving phone stuff from cloud to disk==="
  #rclone move gdrive:/phone-stuff/ $HOME/main/unsorted
  #echo "===Cloud backup==="
  #parallel -j 2 rclone sync $HOME/main ::: {gdrive,50gbmega}:/main
  #rclone sync $HOME/main gdrive:/main
end

# TODO: https://github.com/rclone/rclone/issues/3980
wget --content-disposition https://downloads.rclone.org/v1.53.1/rclone-v1.53.1-linux-amd64.deb
sudo apt install -y ./rclone*.deb

#alias jc 'journalctl'
#alias jcu 'journalctl --user'
alias sc 'systemctl'
alias scu 'systemctl --user'


# gb studio
wget --content-disposition 'https://circleci.com/api/v1.1/project/github/chrismaltby/gb-studio/latest/artifacts/0/builds/gb-studio-v2beta-linux_x86_64.deb?branch=v2beta&filter=successful' -O gb.deb
sudo apt install -y ./gb.deb

function backup
  #test ! -d /media/danet/Data/main && sleep 120
  #echo "===Local backup==="
  #cps $HOME/main /media/danet/Data
  #rclone cleanup gdrive:/
end




# https://wiki.archlinux.org/index.php/Limits.conf
# https://wiki.archlinux.org/index.php/Core_dump
sudo tee -a /etc/security/limits.conf >/dev/null <<END
# https://wiki.archlinux.org/index.php/Limits.conf#core
* soft    core       0           # Prevent corefiles from being generated by default.
* hard    core       unlimited   # Allow corefiles to be temporarily enabled.
END

# Calculate ppi; ppicalc {widght} {height} {display size[eg 27]}
# https://www.designcompaniesranked.com/resources/is-this-retina/
# https://en.wikipedia.org/wiki/Pixel_density#Calculation_of_monitor_PPI
ppicalc() {
  echo 'DPI/PPI is:' "$(bc <<< "sqrt($1^2+$2^2)/$3")"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# https://forum.manjaro.org/t/best-commands-to-shutdown-reboot-via-terminal/40955/8
alias goodnight='qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout 0 2 2 '

# Automatically cd to the directory you were in when quitting ranger if you haven't already:
ranger() {
    tempfile="$(mktemp -t ranger-tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

speedfox() {
  array=( $(pgrep -f plugin-container) )
  array+=( $(pgrep -f ^firefox) )
  for pid in "${array[@]}"; do
    sudo renice -n -20 -p "$pid"
    sudo ionice -c realtime -p "$pid" && echo "Changed io priority to realtime for pid $pid"
  done
}

#/usr/bin/find "$HOMEDIR"/.{config,cache} ! -path "*/syncthing/*" ! -path "*/zplug/*" -empty -delete
#/usr/bin/find "$XDD" ! -path "*/Steam/*" ! -path "*/systemd/*" ! -path "*/lutris/*" -empty -delete

linuxsteamgames() {
  _url="https://store.steampowered.com/search/?category1=998&os="
  for os in win linux mac; do
    local ${os}games="$(curl -s "${_url}${os}" | grep -o "showing 1 - 25 of [0-9]*" | sed "s/showing 1 - 25 of //")"
  done
  echo "Windows steam games: ${wingames}"
  echo "Mac steam games: ${macgames}"
  echo "Linux steam games: ${linuxgames}"
  # https://stackoverflow.com/a/41265735
  echo "Percentage of linux games compared to windows:" $(echo "scale = 2; ($linuxgames / $wingames)" | bc -l | awk -F '.' '{print $2}')%
  echo "Percentage of linux games compared to macOS:" $(echo "scale = 2; ($linuxgames / $macgames)" | bc -l | awk -F '.' '{print $2}')%
}


virtualbox=(
  virtualbox
  virtualbox-ext-oracle
  virtualbox-guest-dkms
  virtualbox-guest-iso
  virtualbox-guest-utils
  virtualbox-host-dkms
)


i3=(
  dragon-drag-and-drop-git
  fe
  kbdd-git
  links
  maim
  network-manager-applet
  pamix-git
  pavucontrol
  pulsemixer
  rofi
  scrot
  sct
  vifm
  mc
  wmctrl
  xautolock
  xsel
)

# not in use anymore
yay -S "${i3[@]}" "${virtualbox[@]}"

# workaround for https://github.com/citra-emu/citra/issues/3862
yuzu-binary() {
  [[ ! -f "libsndio.so.6.1" ]] && ln -sfv /usr/lib/libsndio.so.7.0 libsndio.so.6.1
  LD_LIBRARY_PATH=$PWD strangle 60 gamemoderun ./yuzu
}

px() {
  # https://stackoverflow.com/questions/23258413/expand-aliases-in-non-interactive-shells/23259088#23259088
  setopt aliases
  _command="$(which "$1" | sed 's/.*: aliased to //g' )"
  # http://wiki.bash-hackers.org/syntax/pe#substring_expansion
  eval proxychains -q "$_command" ${@:2}
}

alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"

# some old env
export containter1="$HOME/sync/arch/1"
export containter1l="$HOME/media/veracrypt1"

# extract initramfs
# xzcat /boot/initramfs-linux.img | cpio -idmv --no-absolute-filenames
alias 2ch-vpn="namespaced-openvpn --config $HOME/Documents/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"
alias 2ch-browser="sudo ip netns exec protected sudo -u $USER $HOME/bin/fxlowmem -p $HOME/Documents/fxprofiles/2ch"
alias vpn-pass="sudo ip netns exec protected sudo -u $USER"
alias vpn-proton="namespaced-openvpn --config $HOME/Documents/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"

# Mounts.
#alias m1='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/torrents $HOME/media/server_torrents'
#alias m1a='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/stream $HOME/media/stream'
alias m1ro='test ! -d $containter1l && mkdir $containter1l; veracrypt -v -m=ro -k "" --protect-hidden=no $containter1 $containter1l'
alias m1rw='test ! -d $containter1l && mkdir $containter1l; veracrypt -v  -k "" --protect-hidden=no $containter1 $containter1l'
# Mount veracrypt throught cryptsetup
alias m3test='sudo cryptsetup --veracrypt open --type tcrypt "$containter1" veracrypt; sudo mount /dev/mapper/veracrypt "$containter1l"'

#alias find2chimages='array=( $(fd "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]?[0-9]?[0-9]?[0-9]?\.(png|jpeg|jpg|JPG|jpeg|JPEG|JPE|PNG)$") ); mvi "${array[@]}"'
#alias fixtearing="xrandr --output HDMI-A-0 --mode 1920x1080; xrandr --output HDMI-A-0 --auto"
#alias perf='sudo cpupower frequency-set -g performance'
#alias checksomething='vl -s 2 -t 10 --whitelist example.com file.txt'
#alias checksomething2='awesome_bot -t 10 -w example.com --skip-save-results'
#alias checksomething3='linkcheck'
#cat bookmarks/multimedia/music.txt | sed -e "s/ .*\[.*//g" | fpp -nfc -ai -c firefox --allow-remote

# https://unix.stackexchange.com/questions/78776/characters-encodings-supported-by-more-cat-and-less
#alias ecat='iconv -f WINDOWS-1251 -t UTF-8'

#alias build_mingw='tkgup; cd $HOME/git/PKGBUILDS/mingw && sed -i "s/sudo pacman/yay/g" ./mingw-on-arch-automator.sh; ./mingw-on-arch-automator.sh -f'
#alias build_kernel='tkgup; cd $HOME/git/PKGBUILDS/linux54-tkg && makepkg -si'
#alias build_all_m='build_mingw; build_all'

random() {
  shuf -i "${1}-${2}" -n "${3:-1}"
}

# Validate tar archives
tarval() {
  tar -tJf "$@" >/dev/null
}

checkvk() {
  Estatus=$(proxychains -q curl --http2 -sS "https://api.vk.com/method/users.get?user_id=$1&fields=last_seen,online&v=5.8" || exit)
  case "$(jq '.response[0].last_seen.platform' <<< "$Estatus")" in
    1) platform="мобильная версия" ;;
    4) platform="приложение для Android" ;;
    7) platform="полная версия сайта" ;;
    8) platform="VK Mobile" ;;
    *) platform="Unknown"
  esac
  echo "Онлайн ли сейчас: $(jq '.response[0].online' <<< "$Estatus")"
  echo "Последний раз в сети: $(date -d @$(jq '.response[0].last_seen.time' <<< "$Estatus"))"
  echo "Платформа: $platform"
}

# https://github.com/chrippa/livestreamer/issues/550#issuecomment-222061982
streamnodown() {
  streamlink --loglevel debug --player-external-http --player-no-close --player-external-http-port "5555" --retry-streams 1 --retry-open 100 --stream-segment-attempts 20 --stream-timeout 180 --ringbuffer-size 64M --rtmp-timeout 240 "$1" "${2}"
}

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
# https://github.com/pi-hole/docker-pi-hole/issues/312#issuecomment-412254618
alias internal-ip="ip -o route get to 9.9.9.9 | sed -rn 's/.*src (([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p'"
# https://wiki.archlinux.org/index.php/Mirrors#List_by_speed
alias archmirrorlist='curl -s https://www.archlinux.org/mirrorlist/\?country\=UA\&country\=RU\&country\=FR\&protocol\=https\&use_mirror_status\=on | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -'



while read -r char; do echo "$char"; done < test.txt

# play all in mpv
mpa() { if [[ -d "${PWD}/VIDEO_TS" ]]; then
    mpv "${PWD}"
  else
    files=( $(ls -b ${PWD}/*.{mp4,mkv,webm,avi,wmv} 2>/dev/null) )
    mpv "${PWD}"/"${1:-${files[@]}}" "$2"
  fi
}

# Convert currencies; cconv {amount} {from} {to}
#cconv() {
#  curl --socks5-hostname 127.0.0.1:9250 -s "https://finance.google.com/finance/converter?a=$1&from=$2&to=$3&hl=es" | sed '/res/!d;s/<[^>]*>//g';
#}

sudo tee -a /etc/security/limits.conf >/dev/null <<END
# wine esync
#bausch soft nofile 1048576
#bausch hard nofile 1048576
END
#sudo tee -a /etc/systemd/user.conf >/dev/null <<END
#DefaultLimitNOFILE=1048576
#END
#sudo tee -a /etc/systemd/system.conf >/dev/null <<END
#DefaultLimitNOFILE=1048576
#END


# xdg zsh
#sudo tee /etc/zsh/zshenv >/dev/null <<< 'ZDOTDIR=$XDG_CONFIG_HOME/zsh'

# isntall breeze-grub theme
# https://github.com/gustawho/grub2-theme-breeze
if [[ ! -d /boot/grub/themes ]]; then
 sudo mkdir /boot/grub/themes
 cd /boot/grub/themes || exit 1
 sudo wget https://github.com/gustawho/grub2-theme-breeze/archive/master.tar.gz
 sudo tar --strip-components=1 -xvf master.tar.gz 'grub2-theme-breeze-master/breeze'
 sudo rm master.tar.gz
 # fix https://github.com/gustawho/grub2-theme-breeze/issues/11#issuecomment-492493246
 sudo sed -i -e "\$aleft = 38%\nwidth = 500\ntop = 80%\nheight = 48\ntext_color = "#f2f2f2"\nbar_style = \"progress_bar_*.png\"\nhighlight_style = \"progress_highlight_*.png\"\n}" -e '51,60d' /boot/grub/themes/breeze/theme.txt
fi

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

# как отформатировать то что выдаст lastexport:
sed -i 's/^..........//'
sed -r -i 's/[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+//g'
awk '!x[$0]++'


# https://stackoverflow.com/questions/20568515/how-to-use-sed-to-replace-a-config-files-variable

sudo sed -r 's/^(xserverauthfile=).*/\1$XAUTHORITY/' $(which startx)

# вот этот просто добавляет $XAUTHORITY, а не значение переменной
sudo sed -i '/^xserverauthfile=/s/=.*/=$XAUTHORITY/' $(which startx)
sudo sed -i '/\(^xserverauthfile=\).*/ s//\1$XAUTHORITY/' $(which startx)
sudo sed -i 's/^\(xserverauthfile=\).*/\1$XAUTHORITY/' $(which startx)

# А эти раскрывают переменную
sudo sed -i 's,^\(xserverauthfile=\).*,\1'$XAUTHORITY',' $(which startx)
sudo sed -i "s|xserverauthfile=$HOME/.serverauth.$$|xserverauthfile=$XAUTHORITY|g" $(which startx)



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
