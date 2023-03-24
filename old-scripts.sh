#!/bin/bash


# https://www.computerhope.com/issues/ch001762.htm
powercfg -h off

# https://www.tutorialspoint.com/how-to-remove-pagefile-on-the-specific-drive-using-powershell
$pagefileset = Gwmi win32_pagefilesetting | where{$_.caption -like 'C:*'}
$pagefileset.Delete()


# https://microsoft.github.io/Git-Credential-Manager-for-Windows/Docs/Askpass.html
# https://github.com/git-for-windows/git/issues/1613
# https://github.com/git-lfs/git-lfs/issues/1843
# https://github.com/git-for-windows/git/issues/1683
# https://github.com/PowerShell/Win32-OpenSSH/issues/1234#issuecomment-824709477
# https://github.com/desktop/desktop/issues/11918
# https://github.com/desktop/desktop/issues/5641
#setx GIT_ASKPASS "C:\\Program Files\\Git\\mingw64\\libexec\\git-core\\git-gui--askpass"
#setx SSH_ASKPASS "C:\\Program Files\\Git\\mingw64\\libexec\\git-core\\git-gui--askpass"
#setx DISPLAY "required"


# disable fast boot
#REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 0 /F

# fix https://github.com/microsoft/WSL/issues/4103
# replace with compact? `compact /?`
#Install-Module -Force -Name Carbon
#Import-Module 'Carbon'
#mkdir "$env:USERPROFILE\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState"
#Disable-CNtfsCompression -Path "$env:USERPROFILE\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState"

# fix https://github.com/microsoft/WSL/issues/5336#issuecomment-770494713
#Disable-CNtfsCompression -Path "$env:TEMP"
#compact /C "$env:TEMP"
#New-Item -Path "$env:TEMP/swap.vhdx" -ItemType File
#compact /U "$env:TEMP/swap.vhdx"


#alias build_mainline 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg'
#alias build_staging 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg'
#alias tkgup 'cd $HOME/git/PKGBUILDS; git reset --hard origin/frogging-family; git submodule foreach --recursive git reset --hard origin; git pull'
#alias badlinks 'find . -type l -exec test ! -e {} \; -print'


#systemctl --user enable --now syncthing
#chsh -s /usr/bin/fish
#systemctl enable --now amdgpu

alias speak2 "wget -U firefox -qO - 'https://translate.google.com/translate_tts?tl=ru-RU&client=tw-ob&q=%D0%BD%D0%B5%D1%82%20%D0%BD%D0%B5%20%D0%B7%D0%BD%D0%B0%D1%8E' | xclip -selection clipboard"

# esc is broken
#xmodmap ~/.Xmodmap


#alias synctomega 'rclone sync -P --exclude .overgrive\* $HOME/main 50gbmega:/main'

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.mp3
  #ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg # do i need this?
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end


  #if not functions -q fisher
  #  curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
  #  fish -c fisher
  #end
  #bass source /etc/profile
  #bass source $HOME/.profile
#set -gx PATH $PATH $HOME/.local/share/npm/bin


SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# vmware https://www.namhuy.net/227/enable-3d-hardware-graphics-acceleration-for-vmware-workstation-on-ubuntu
echo 'mks.gl.allowBlacklistedDrivers = "TRUE"' >> "$HOME/.vmware/preferences"

# dupeguru https://github.com/arsenetar/dupeguru/issues/484
git clone --depth=1 https://github.com/arsenetar/dupeguru /tmp/dupeguru
cd /tmp/dupeguru || exit 1
bash -c "python3 -m venv --system-site-packages env && source env/bin/activate && pip install -r requirements.txt && python3 build.py --clean && python3 package.py"
cd build || exit 1
sudo apt install ./dupeguru*.deb

# snaps https://snapcraft.io/docs/keeping-snaps-up-to-date
# https://bugs.launchpad.net/snappy/+bug/1887217
sudo snap set system refresh.retain=2
sudo snap set system refresh.timer=fri,9:00~21:00

# firefox audio speaker
speech-dispatcher espeak-ng festival

#[very-big-cache]
#demuxer-readahead-secs=6000

# https://www.reddit.com/r/mpv/comments/ecrhwi/reduce_playlist_font_size/fbdfp64
#osd-font-size=21

#h apply-profile "very-big-cache"; show-text "very-big-cache";


# https://bugs.kde.org/show_bug.cgi?id=428094
#mkdir "$HOME/.config/autostart"
#sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop"

# https://bugs.kde.org/show_bug.cgi?id=413053#c12
#/usr/lib/x86_64-linux-gnu/libexec/DiscoverNotifier --hide


  #sudo apt update
  #sudo apt upgrad
  #flatpak --user update --noninteractive
  #snap refresh
  #fwupdmgr refresh
  #fwupdmgr update



#alias cps 'rsync --archive --compress --progress --verbose --executability -h --update --delete'
#alias tlg2 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop2'

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

# avoid problems like this https://github.com/flathub/com.mojang.Minecraft/issues/6
# https://bugs.kde.org/show_bug.cgi?id=430801
# https://bugs.kde.org/show_bug.cgi?id=422339
#sudo update-locale --reset


# https://unix.stackexchange.com/questions/421066/popup-language-support-is-incomplete-what-packages-does-it-want-to-install
# script wrongly assumes that ru_UA is uk, or it looks into wrong locale env https://bugs.kde.org/show_bug.cgi?id=430801, https://bugs.launchpad.net/ubuntu/+source/language-selector/+bug/1910692
# https://bugs.kde.org/show_bug.cgi?id=431292
# shellcheck disable=SC2046
#sudo apt install --install-suggests --ignore-missing $(check-language-support -l ru_UA)


# https://bugzilla.mozilla.org/show_bug.cgi?id=788319
#set -gx MOZ_X11_EGL 1

# https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/issues/1133
function freetypecleartype
  fd -t f -H -I "libfreetype.so*" --search-path /var/lib/flatpak -x sudo cp -fv (realpath /usr/lib/x86_64-linux-gnu/libfreetype.so.6) {}
  # fix `/app/extra/viber/Viber: error while loading shared libraries: libbrotlidec.so.1: cannot open shared object file: No such file or directory`
  # will be fixed by https://github.com/flathub/com.viber.Viber/pull/27
  #sudo cp -v /var/lib/flatpak/runtime/org.kde.Platform/x86_64/5.15/active/files/lib/x86_64-linux-gnu/libbrotli* /var/lib/flatpak/runtime/org.freedesktop.Platform/x86_64/19.08/active/files/lib/x86_64-linux-gnu
end


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

# ipega sdl bindings https://github.com/libsdl-org/SDL/pull/4060
#export SDL_GAMECONTROLLERCONFIG="05000000491900000204000000000000,Ipega PG-9087S - Bluetooth Gamepad,a:b0,b:b1,y:b4,x:b3,start:b11,back:b10,leftstick:b13,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9,platform:Linux,"


# mpv.net config
#Add-Content -Path "$env:APPDATA\mpv.net\mpv.conf" -Value "`nno-keepaspect-window"

# https://stackoverflow.com/questions/30496116/how-to-disable-hyper-v-in-command-line
bcdedit /set hypervisorlaunchtype off

# fix https://github.com/microsoft/WSL/issues/4103
compact /U "$env:USERPROFILE\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState"


# setup mpv.net
"ytdl-raw-options=mark-watched=,cookies-from-browser=firefox,write-auto-subs=,`nytdl-format=bestvideo[vcodec^=avc1]+bestaudio[ext=m4a]`nsub-pos=90`n" + (Get-Content "$env:APPDATA\mpv.net\mpv.conf" -Raw) | Set-Content "$env:APPDATA\mpv.net\mpv.conf"


# config files, git
Remove-Item -Path "$env:USERPROFILE\.gitconfig"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target ".\.gitconfig"
New-Item -ItemType SymbolicLink -Path "C:\tools\msys64\home\user\.gitconfig" -Target ".\.gitconfig"
# ssh
New-Item -ItemType Junction -Path "C:\tools\msys64\home\user\.ssh" -Target "$env:USERPROFILE\.ssh"
# mpv
Remove-Item -Path "$env:APPDATA\mpv\*.conf"
mkdir "$env:APPDATA\mpv\scripts"
#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/pause-when-minimize.lua" -OutFile "$env:APPDATA\mpv\scripts\pause-when-minimize.lua"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\mpv\mpv.conf" -Target ".\mpv.conf"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\mpv\input.conf" -Target ".\input.conf"
# zsh
Remove-Item -Path "C:\tools\msys64\home\user\.zshrc"
mkdir "C:\tools\msys64\home\user"
New-Item -ItemType SymbolicLink -Path "C:\tools\msys64\home\user\.zshrc" -Target ".\.zshrc"
# microsoft windows terminal
Remove-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
mkdir "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Target ".\mswinterminal.json"

# https://mspscripts.com/disable-windows-10-fast-boot-via-powershell/
# leave disabled if you use dualboot or wifi adapters
#reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f

#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/pause-when-minimize.lua" -OutFile "$env:APPDATA\mpv\scripts\pause-when-minimize.lua"

C:\tools\msys64\mingw64.exe bash.exe -c 'ln -Pfv /c/Users/User/git/dotfiles_windows/dotfiles/.gitconfig $HOME'



# https://richardballard.co.uk/ssh-keys-on-windows-10/
#Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service

# https://remontka.pro/compact-os-windows-10/
#compact /compactos:never

# hide user folders in "this pc"
#Invoke-WebRequest -Uri "https://git.io/JMGtW" -OutFile "$env:TEMP/temp.reg"
#reg import "$env:TEMP/temp.reg"

#reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v DoHPolicy /t REG_DWORD /d "3" /f

#echo vitetris --connect (exip):27015 && 
#alias nvmestats 'sudo smartctl -A /dev/nvme0'
#alias exip 'curl -s https://ipecho.net/plain'

# add python to path
# TODO: better to install python with winget once https://github.com/microsoft/winget-cli/issues/219 and https://github.com/microsoft/winget-cli/issues/212 is resolved
#setx PATH "$env:PATH;$env:APPDATA\Python\Python310\Scripts"

#Add-WindowsCapability -Online -Name OpenSSH.Client

#Remove-Item -Path "$env:APPDATA\mpv\*.conf"
#Remove-Item -Path "C:\tools\msys64\home\user\.zshrc"

# swap
wmic computersystem set AutomaticManagedPagefile=False
wmic pagefileset set InitialSize=4096,MaximumSize=4096


# TODO: is mkdir needed with dploy?
#mkdir "$env:APPDATA\mpv"
#mkdir "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

# fix https://github.com/msys2/MSYS2-packages/issues/138#issuecomment-775316680
#C:\tools\msys64\mingw64.exe bash.exe -c 'mkpasswd > /etc/passwd; mkgroup > /etc/group; sed -i "s/db//g" /etc/nsswitch.conf'

# git for windows uses wrong ssh binary which leads to errors like `Permission Denied (publickey)` because it don't use windows ssh-agent
# https://github.com/PowerShell/Win32-OpenSSH/wiki/Setting-up-a-Git-server-on-Windows-using-Git-for-Windows-and-Win32_OpenSSH#on-client
# https://github.com/PowerShell/Win32-OpenSSH/issues/1136#issuecomment-382074202
#setx GIT_SSH_COMMAND "C:\\Windows\\System32\\OpenSSH\\ssh.exe -T"


# https://answers.microsoft.com/en-us/windows/forum/all/opening-a-folder-adds-shortcut-under-this-pc-in/8c0de37a-e517-457d-8ce6-b39ce9e5c04e
# https://www.tenforums.com/customization/96893-updating-reg-file-removing-folder-pc.html
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Desktop
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Documents
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Downloads
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Movies
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Music
Set-ItemProperty -Path HKLM:\"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Value Hide # Pictures

# https://winaero.com/hide-removable-drives-navigation-pane-windows-10/
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f

# unneeded
#Set-Service -Name "ClickToRunSvc" -Status stopped -StartupType disabled

# trakt tv sync
python -m pip install pipx
pipx ensurepath
#$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") # https://stackoverflow.com/questions/17794507/powershell-reload-the-path-in-powershell
pipx install trakt-scrobbler
trakts auth
trakts config set players.monitored mpv
trakts config set fileinfo.whitelist B:\ # TODO: add dynamic disk letter detection
trakts config set general.enable_notifs False
"input-ipc-server=\\.\pipe\mpvsocket`n" + (Get-Content "$env:APPDATA\mpv.net\mpv.conf" -Raw) | Set-Content "$env:APPDATA\mpv.net\mpv.conf"
trakts config set players.mpv.ipc_path \\.\pipe\mpvsocket

# fix https://github.com/microsoft/WSL/issues/5336#issuecomment-770494713
Set-Content -Path "$env:USERPROFILE\.wslconfig" -Value "[wsl2]`nswap=0"


bash.exe -c 'sudo apt update && sudo add-apt-repository -y ppa:fish-shell/release-3 && sudo apt upgrade -y && sudo apt install -y python3-pip pipx fish && pip install --user internetarchive && pipx install tubeup && fish -c \"curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure\" && chsh -s /usr/bin/fish && wget -O $HOME/.config/fish/config.fish https://github.com/soredake/dotfiles_home/raw/kubuntu/home/fish/.config/fish/config.fish && echo \"fish_add_path \$HOME/.local/bin\" >> ~/.config/fish/config.fish'
ln -sfv ~/.config/internetarchive/ia.ini ~/.config/ia.ini
mkdir ~/.ia
ln -sfv ~/.config/internetarchive/ia.ini ~/.ia/ia.ini



# https://github.com/microsoft/WSL/issues/4901#issuecomment-1027762021
#Disable-NetAdapterLso -Name "vEthernet (WSL)"

# https://github.com/farag2/Sophia-Script-for-Windows/blob/d1e5ce4c20ee30e2d8fbefc63807289ac7cbd1be/Sophia%20Script/Sophia%20Script%20for%20Windows%2011%20PowerShell%207/Module/Sophia.psm1#L11466
#New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo -Name "(default)" -PropertyType String -Value "-{7BA4C740-9E81-11CF-99D3-00AA004AE837}" -Force
# https://github.com/farag2/Sophia-Script-for-Windows/blob/d1e5ce4c20ee30e2d8fbefc63807289ac7cbd1be/Sophia%20Script/Sophia%20Script%20for%20Windows%2011%20PowerShell%207/Module/Sophia.psm1#L11142
#New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Force
#New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" -PropertyType String -Value "Play to menu" -Force

$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\128Bit-Yuzu Maintenance Tool.lnk")
$Shortcut.TargetPath = "$env:LOCALAPPDATA\128Bit-Yuzu\maintenancetool.exe"
$Shortcut.Save()

# disable hibernation
powercfg /hibernate off

choco install -y msys2

# msys2, python is neeed for npm/yarn completion in fish
C:\tools\msys64\mingw64.exe pacman.exe -S --noconfirm zsh fish python diffutils winpty

mkdir "C:\tools\msys64\home\user"
New-Item -ItemType SymbolicLink -Path "C:\tools\msys64\home\user\.zshrc" -Target ".\.zshrc"
New-Item -ItemType SymbolicLink -Path "C:\tools\msys64\home\user\.gitconfig" -Target ".\dotfiles\.gitconfig"
New-Item -ItemType Junction -Path "C:\tools\msys64\home\user\.ssh" -Target "$env:USERPROFILE\.ssh"

# "Give me updates for other Microsoft products when I update Windows", https://github.com/Disassembler0/Win10-Initial-Setup-Script/issues/250#issuecomment-503887779
#(New-Object -ComObject Microsoft.Update.ServiceManager).AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "")

function upgradeall { C:\tools\msys64\mingw64.exe pacman.exe -Syu --noconfirm}


# https://github.com/microsoft/winget-cli/discussions/1738
#Install-Package Microsoft.UI.Xaml -Version 2.7.1
#Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$env:TEMP/winget.msixbundle"
#Add-AppPackage -Path "$env:TEMP/winget.msixbundle"


# i don't need this thanks https://github.com/AveYo/MediaCreationTool.bat/blob/8a54cb4be75be05636c2bc20841f5b2338c14a58/MediaCreationTool.bat#L833-L835
#New-ItemProperty -Path 'HKCU:\Control Panel\UnsupportedHardwareNotificationCache' -Name 'SV2' -Value 0 -PropertyType DWord -Force


# https://pureinfotech.com/enable-hardware-accelerated-gpu-scheduling-windows-11/
#New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name HwSchMode -PropertyType DWord -Value 2 -Force

# https://github.com/PowerShell/PowerShell/issues/14216#issuecomment-1084010061
#Invoke-WebRequest -Uri "https://gist.githubusercontent.com/soredake/9e7b6fc7f04d9d96a2fc798b25d5186f/raw/powershell_context_shell_fix.reg" -OutFile "$env:TEMP/powershell_context_shell_fix.reg"
#reg import "$env:TEMP/powershell_context_shell_fix.reg"

#Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force


::Уменьшение времени ожидания загрузки ОС по умолчанию, если в меню более 1 пункта
::bcdedit /timeout 3
::Отключаем графический менеджер загрузки Windows 8 и выше (начинает работать меню по нажатии кнопки F8)
bcdedit /set {current} bootmenupolicy legacy
::Отключение автоматического восстановления при сбоях загрузки
bcdedit /set recoveryenabled NO

# disable lock screen, https://superuser.com/a/1659652/1506333 https://www.techrepublic.com/article/how-to-disable-the-lock-screen-in-windows-11-an-update/
#$Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
#If ( -Not ( Test-Path "Registry::$Key")){New-Item -Path "Registry::$Key" -ItemType RegistryKey -Force}
#Set-ItemProperty -path "Registry::$Key" -Name "NoLockScreen" -Type "DWORD" -Value 1

# https://github.com/po5/mpv_sponsorblock
#git clone --depth=1 "https://github.com/po5/mpv_sponsorblock.git" $env:APPDATA\mpv.net\scripts
#Remove-Item -LiteralPath "$env:APPDATA\mpv.net\scripts\.git" -Force -Recurse
#Remove-Item "$env:APPDATA\mpv.net\scripts\*" -include README.md, LICENSE
# https://www.kittell.net/code/powershell-unix-sed-equivalent-change-text-file/
#(Get-Content $env:APPDATA\mpv.net\scripts\sponsorblock.lua).replace('local_database = true', 'local_database = false') | Set-Content $env:APPDATA\mpv.net\scripts\sponsorblock.lua


# safeeyes pip
#packages+=(libappindicator-gtk3 python3-psutil cairo-devel python3-devel gobject-introspection-devel cairo-gobject-devel) # safeeyes https://github.com/slgobinath/SafeEyes/issues/432
sudo pip install safeeyes
#gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" # safeeyes


ForEach ($task in "\Achievement Watcher Upgrade OnLogon","\OneDrive Reporting Task-S-1-5-21-10046236-1389244250-3883847028-500","\OneDrive Standalone Update Task-S-1-5-21-10046236-1389244250-3883847028-500") { schtasks /delete /tn "$task" /f }

#ytdl-raw-options=extractor-args="youtube:player-client=ios"
# avc1 uses nv12, av01/vp9 uses yuv420
#ytdl-format=bestvideo[vcodec^=avc1]+bestaudio[ext=m4a]
#ytdl-format=bestvideo[height<=?720]+bestaudio/best
#ytdl-format=bestvideo[height<=?720][vcodec^=avc1]+bestaudio[ext=m4a]
#demuxer-max-bytes=512MiB
#cache-secs=600

curl --create-dirs -O --output-dir "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua https://raw.githubusercontent.com/ekisu/mpv-webm/master/build-webm-conf.lua
wget -P "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua https://raw.githubusercontent.com/ekisu/mpv-webm/master/build-webm-conf.lua
#aria2c -c -d "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua

#export PLASMA_USE_QT_SCALING=1 # https://bugs.kde.org/show_bug.cgi?id=356446

# https://www.reddit.com/r/Windows11/comments/qs96dp/comment/hkbp794/ or https://www.ghacks.net/2021/10/08/how-to-uninstall-widgets-in-windows-11/
# https://aka.ms/AAgnpjd https://aka.ms/AAh103i
Get-AppxPackage MicrosoftWindows.Client.WebExperience* | Remove-AppxPackage

pip install --user git+https://github.com/simons-public/protonfixes # protonfixes is included with proton-ge, and i will use it anyway
#echo -e "fastestmirror=True"|sudo tee -a /etc/dnf/dnf.conf
#sudo dnf copr enable dawid/better_fonts -y

# https://snapcraft.io/docs/installing-snap-on-fedora
#sudo systemctl start snapd; sudo ln -s /var/lib/snapd/snap /snap

# TODO: https://pagure.io/fedora-workstation/issue/283
#sudo snap install code --classic # https://github.com/microsoft/vscode/issues/141788 https://packages.microsoft.com/yumrepos/vscode https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # TODO: https://pagure.io/fedora-workstation/issue/300

# syncplay
#wget -c https://github.com/$(wget -q https://github.com/Syncplay/syncplay/releases -O - | grep "Syncplay.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)

#sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop" # https://bugs.kde.org/show_bug.cgi?id=413053

# TODO: wsl --update will not be needed in future https://devblogs.microsoft.com/commandline/a-preview-of-wsl-in-the-microsoft-store-is-now-available/


# https://github.com/bibanon/tubeup/issues/172
#mkdir ~/.ia
#ln -sfv ~/.config/internetarchive/ia.ini ~/.config/ia.ini
#ln -sfv ~/.config/internetarchive/ia.ini ~/.ia/ia.ini

(Get-Content $env:APPDATA\mpv.net\scripts\sponsorblock_minimal.lua).replace(',"intro","outro","interaction","selfpromo"','') | Set-Content $env:APPDATA\mpv.net\scripts\sponsorblock_minimal.lua # https://codeberg.org/jouni/mpv_sponsorblock_minimal/pulls/6

# https://codeberg.org/jouni/mpv_sponsorblock_minimal
Invoke-WebRequest -Uri "https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/branch/master/sponsorblock_minimal.lua" -OutFile $env:APPDATA\mpv.net\scripts\sponsorblock_minimal.lua
# https://github.com/fbriere/mpv-scripts/tree/master/scripts
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fbriere/mpv-scripts/master/scripts/tree-profiles.lua" -OutFile $env:APPDATA\mpv.net\scripts\tree-profiles.lua
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fbriere/mpv-scripts/master/scripts/brace-expand.lua" -OutFile $env:APPDATA\mpv.net\scripts\brace-expand.lua


# shortcuts, https://stackoverflow.com/a/31815367
$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\RTSS.lnk"); $Shortcut.TargetPath = "C:\Program Files (x86)\RivaTuner Statistics Server\RTSS.exe"; $Shortcut.Save() # TODO: propose creating a link for it here https://github.com/HunterZ/choco
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\BreakTimer - disable.lnk"); $Shortcut.TargetPath = "$env:LOCALAPPDATA\Programs\breaktimer\BreakTimer.exe"; $Shortcut.Arguments = "disable"; $Shortcut.Save()
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\BreakTimer - enable.lnk"); $Shortcut.TargetPath = "$env:LOCALAPPDATA\Programs\breaktimer\BreakTimer.exe"; $Shortcut.Arguments = "enable"; $Shortcut.Save()

# https://stackoverflow.com/a/31602095
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# cleanup scheduled tasks https://aka.ms/AAh3y2n
#ForEach ($task in "OneDrive*") { Unregister-ScheduledTask "$task" -Confirm:$false }
# explorer tweaks https://stackoverflow.com/a/8110982/4207635
#$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
#Set-ItemProperty $key Hidden 1; Set-ItemProperty $key HideFileExt 0
# https://www.ghacks.net/2021/10/22/how-to-remove-chat-in-windows-11/
#reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /f /v ChatIcon /t REG_DWORD /d 3

# https://www.free-codecs.com/download/hevc_video_extension.htm
#Invoke-WebRequest -Uri "https://www.free-codecs.com/download_soft.php?d=0ca6d1645416c69a1655fb4af4e2d6ab&s=1024&r=&f=hevc_video_extension.htm" -OutFile "$env:TEMP/hevc_extension.appx"
#Add-AppPackage -Path "$env:TEMP/hevc_extension.appx"

# enable cloudflare dns with DOH https://superuser.com/a/1626051/1506333 https://winitpro.ru/index.php/2020/07/10/nastroyka-dns-over-https-doh-v-windows. https://aka.ms/AAh4e0n
#Set-DnsClientServerAddress -InterfaceIndex (Get-NetRoute | % { Process { If (!$_.RouteMetric) { $_.ifIndex } } }) -ServerAddresses "1.1.1.1","1.0.0.1"
#New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'EnableAutoDoh' -Value 2 -PropertyType DWord -Force

#sudo get-appbackgroundtask | Where-Object -Property entrypoint -like "OmenCommandCenterApp*" | select taskid | foreach {unregister-appbackgroundtask -taskid $_.TaskId} # https://sysxnull.blogspot.com/2020/03/unregister-background-tasks-with.html
sudo choco install -y AdoptOpenJDK11openj9 --params="/ADDLOCAL=FeatureJavaHome"

cache=yes
demuxer-max-bytes=2GiB
demuxer-readahead-secs=300

    //"terminal.integrated.shell.windows": "C:\\tools\\msys64\\msys2_shell.cmd",
    //"terminal.integrated.shellArgs.windows": ["-defterm", "-no-start", "-mingw64", "-use-full-path", "-here", "-shell", "zsh"],


Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name "MicrosoftEdgeAutoLaunch_8714F0D917266FE3AFB7F8BB98EEBC18"

  // https://stackoverflow.com/a/46838044
    "ZSH/MSYS2": {
      "path": "C:\\tools\\msys64\\usr\\bin\\zsh.exe",
      "args": ["--login", "-i"],
      "overrideName": true,
      "icon": "C:\\tools\\msys64\\usr\\bin\\zsh.exe",
      "env": {
        "MSYSTEM": "MINGW64",
        "MSYS2_PATH_TYPE": "inherit",
        "CHERE_INVOKING": "1"
      }
    },


# -e "/^BTRFS_DEFRAG_PERIOD=/s/=.*/=\"monthly\"/" -e "/^BTRFS_DEFRAG_PATHS=/s/=.*/=\"\/\"/" https://github.com/kdave/btrfsmaintenance/issues/86


Set-ScheduledTask WakeUpAndContinueUpdates -Settings waketorun:$false
Set-ScheduledTask WakeUpAndScanForUpdates -Settings waketorun:$false
Set-ScheduledJobOption -WakeToRun:$false WakeUpAndContinueUpdates
Register-ScheduledJob -Name 'WakeUpAndContinueUpdates' -ScheduledJobOption (New-ScheduledJobOption -WakeToRun:$false)
Get-ScheduledJob -Name 'WakeUpAndContinueUpdates' | Set-ScheduledJobOption -WakeToRun:$false
Get-ScheduledJob -Name "WakeUpAndContinueUpdates" | Get-ScheduledJobOption | Set-ScheduledJobOption -WakeToRun:$false


# New-Shortcut -Name 'Ryujinx' -Path $HOME\Desktop -Target "C:\tools\ryujinx\publish\Ryujinx.exe" # https://github.com/ark0f/choco-ryujinx/issues/11

# disable autorun for all devices
#sudo reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'NoAutoplayfornonVolume' /t REG_DWORD /d 1 /f
#sudo reg add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoDriveTypeAutoRun' /t REG_DWORD /d 255 /f

# sudo pwsh -c 'Set-ScheduledTask -TaskName Winget-AutoUpdate -Trigger (New-ScheduledTaskTrigger -Weekly -At 12:00 -DaysOfWeek 2)'

#ForEach ($app in '64gram','achievement-watcher','ryujinx','steam-rom-manager','itch','zoom','powertoys','keepassxc','googledrive','parsec','goggalaxy','hamachi','protonvpn','steam-client','rpcs3','pcsx2-dev','tor-browser','hidhide') { sudo choco pin add -n="$app"} # https://github.com/chocolatey/choco/issues/1607


# allow built-in update to work
# sudo takeown /a /r /d Y /f C:\ProgramData\chocolatey\lib\ds4windows\tools\DS4Windows
# sudo icacls "C:\ProgramData\chocolatey\lib\ds4windows\tools\DS4Windows" /grant Пользователи:F # https://stackoverflow.com/questions/2928738/how-to-grant-permission-to-users-for-a-directory-using-command-line-in-windows
# New-Item -ItemType HardLink -Path "$HOME\.config\ia.ini" -Target "$HOME\.config\internetarchive\ia.ini"

# Remove-Item -Path 'HKCU:\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current' -Force; Remove-Item -Path 'HKCU:\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current' -Force
# Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Achievement Watcher.lnk"; Remove-Item -Path "$HOME\Desktop\Google Docs.lnk"; Remove-Item -Path "$HOME\Desktop\Google Sheets.lnk"; Remove-Item -Path "$HOME\Desktop\Google Slides.lnk"

#sudo dnf copr enable elxreno/bees -y
#sudo grubby --update-kernel=ALL --args="retbleed=off" # https://www.reddit.com/r/Amd/comments/vyaqwf/comment/ig1x0kq/
# bees setup
# export UUID="$(blkid -o value -s UUID /dev/nvme0n1p2)"
# sudo cp /etc/bees/beesd.conf.sample /etc/bees/$UUID.conf
# sudo sed -i "s|xxxxxxxx-xx.*|$UUID|" /etc/bees/$UUID.conf
# sudo systemctl enable --now beesd@$UUID.service


# https://devblogs.microsoft.com/commandline/a-preview-of-wsl-in-the-microsoft-store-is-now-available/dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all https://github.com/microsoft/WSL/releases/tag/0.50.2 https://www.microsoft.com/store/productId/9P9TQF7MRM4R https://www.microsoft.com/store/productId/9PDXGNCFSCZV

# 
# 
# 
# 
# # sudo dnf module install -y nodejs:18/common


  #C:\Program` Files\7-Zip\7z.exe -mx=9 a "C:\Users\User\Мой диск\документы\backups\rpcs3_saves.zip" "C:\tools\RPCS3\dev_hdd0\home\00000001\savedata\*"
  #Start-Sleep -Seconds 20

# [4k60]
profile-desc=Mess up video when entering fullscreen
profile-cond=(width >= 2560 and p["estimated-vf-fps"]>=60)
profile-restore=copy
video-sync=audio
# vd-lavc-dr=yes
# hwdec=no
# scale=bilinear
# cscale=bilinear
# dscale=bilinear
# deband=no
# sigmoid-upscaling=no
# linear-downscaling=no
# correct-downscaling=no
# dither-depth=no
# # profile=gpu-hq
deband=no
sws-allow-zimg=yes
sws-scaler=bilinear
sws-fast=yes
zimg-scaler=bilinear
zimg-dither=no
dither-depth=no
scale=bilinear
cscale=bilinear
dscale=bilinear
scale-antiring=0
cscale-antiring=0
dither-depth=no
correct-downscaling=no
sigmoid-upscaling=no
hdr-compute-peak=no
d3d11va-zero-copy=yes



# https://windowsloop.com/how-to-remove-amd-radeon-software-from-context-menu/
# sudo reg delete "HKLM\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\ACE" /f


# fix lychee selecting wrong adapter https://support.logmeininc.com/central/help/why-does-my-internet-connection-fail-when-hamachi-is-enabled https://cloudrun.co.uk/windows10/set-network-interface-priority-in-windows-10-using-set-netipinterface/ https://github.com/lycheeverse/lychee/issues/902 https://github.com/lycheeverse/lychee/issues/902
# sudo 'Get-NetAdapter | Where-Object -FilterScript {$_.InterfaceAlias -like "Hamachi"} | Set-NetIPInterface -InterfaceMetric 9999' # TODO: report this there https://github.com/seanmonstar/reqwest https://github.com/hyperium/hyper TODO: if i put 9999 to metric to hamachi it timeouts less often, disable adapther fixes the issue https://github.com/lycheeverse/lychee/issues/902#issuecomment-1372842422


# sudo schtasks /create /tn "switch language with right ctrl" /sc onlogon /rl highest /tr "$HOME\lswitch.exe 163"
# schtasks /run /tn "switch language with right ctrl"


# New-Shortcut -Name 'PPSSPP' -Path $HOME\Desktop -Target "C:\Program Files\PPSSPP\PPSSPPWindows64.exe" # TODO: будут ли при апдейте созданы ярлыки обратно? https://github.com/kzdixon/chocolatey-packages/commit/66e63fe217c4d9d22210a09f3d555ff3da880cf6


#sudo corepack enable; yarn set version stable # https://yarnpkg.com/getting-started/install https://nodejs.org/dist/latest/docs/api/corepack.html

# stop device connect/remove sound
#Remove-Item -Path 'HKCU:\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current','HKCU:\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current' -Force

[sample]
profile-desc="tree:E:\folder"
sid=2


sudo robocopy H:\ E:\ /MIR /COPYALL /Z /B /J /R:3 /W:1 /REG /TEE

# mirror external disk to another external disk
# Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" -Argument '--title "mirror external disk to another external disk" pwsh -c mirrorexternaldisk') -TaskName "External disk mirroring" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 12:00)

function mirrorexternaldisk {
  if (Test-Path -Path "\\WIN-KTRSBU9GE9P\Transcend\mirror") {
    rclone sync -P --progress-terminal-title --exclude "backups/" --exclude '$RECYCLE.BIN/' --exclude 'System Volume Information/' --exclude 'w3/' --exclude 'music/' --exclude 'Windows*/' --exclude 'WinPE*/' E:\ \\WIN-KTRSBU9GE9P\Transcend\mirror
  }
}


if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#  http://time.in.ua/
# https://techgenix.com/windows-time-sync-issues/
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"ntp.time.in.ua ntp3.time.in.ua"
net start w32time
w32tm /config /update
w32tm /resync /rediscover


PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File $PWD\setup-winget.ps1' -Verb RunAs}";
