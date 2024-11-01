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

# link windows terminal config
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File $PWD\\link-windows-terminal-config.ps1' -Verb RunAs}";

# choco install -y wsldiskshrinker
#sudo wsl --install --no-launch #Ubuntu # https://github.com/microsoft/WSL/issues/9266


if ($PSVersionTable.PSEdition -ne "Core") {
  # setup winget https://github.com/microsoft/winget-cli/discussions/1691#discussioncomment-1684313 https://www.tenforums.com/general-support/50444-how-run-ps1-file-administrator.html#post670680
  #Start-Process powershell -ArgumentList "-c (Get-AppxProvisionedPackage -Online -LogLevel Warnings | Where-Object -Property DisplayName -EQ Microsoft.DesktopAppInstaller).InstallLocation -replace '%SYSTEMDRIVE%', '$env:SystemDrive' | Add-AppxPackage -Register -DisableDevelopmentMode" -Verb runAs
  # install pwsh
  winget install -h --accept-package-agreements --accept-source-agreements Microsoft.PowerShell
  pwsh $PSCommandPath
  exit
}


# https://winaero.com/windows-10-deleting-thumbnail-cache/
# sudo Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail` Cache' -Name 'Autorun' -Value 0 -Force


sudo Set-DnsClientServerAddress -InterfaceIndex (Get-NetRoute | % { Process { If (!$_.RouteMetric) { $_.ifIndex } } }) -ServerAddresses "1.1.1.1", "1.0.0.1"

# "DefaultTerminalApp -WindowsTerminal" https://www.phoronix.com/news/Windows-11-22H2-Terminal https://devblogs.microsoft.com/commandline/windows-terminal-is-now-the-default-in-windows-11/

# TODO: sophiscript
# CleanupTask -Register, SoftwareDistributionTask -Register, TempTask -Register, StorageSenseTempFiles -Enable, GPUScheduling -Enable, StorageSense -Enable, StorageSenseFrequency -Month, WindowsSandbox -Enable



# sudo Set-Service -Name "AUEPLauncher" -Status stopped -StartupType disabled
# sudo Disable-ScheduledTask "StartAUEP"

# https://wccftech.com/how-to/how-to-disable-windows-10-background-apps/ https://www.outsidethebox.ms/21739/
# reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f

New-Shortcut -Name 'RTSS' -Path $HOME\Desktop -Target "C:\Program Files (x86)\RivaTuner Statistics Server\RTSS.exe"


# https://github.com/farag2/Sophia-Script-for-Windows/blob/bd7857d984f92397839b2c73f7536c0bafbc8fdd/src/Sophia_Script_for_Windows_11_PowerShell_7/Module/Sophia.psm1#L13000-L13008
  sudo New-NetIPAddress -InterfaceIndex (Get-NetAdapter -Physical | ? {$_.Status -eq "Up"} | Select ifIndex | Select-String -Pattern "[0-9]+" | % { $_.Matches } | % { $_.Value}) -IPAddress 192.168.0.145 -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway 192.168.0.1
  # sudo Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter -Physical | ? {$_.Status -eq "Up"} | Select ifIndex | Select-String -Pattern "[0-9]+" | % { $_.Matches } | % { $_.Value}) -ServerAddresses "1.1.1.1", "1.0.0.1"

New-Shortcut -Name 'Yuzu EA no update' -Path $HOME\Desktop -Target "$env:LOCALAPPDATA\yuzu\yuzu-windows-msvc-early-access\yuzu.exe" # https://github.com/yuzu-emu/yuzu/issues/9380

sudo Disable-ScheduledTask "SystemOptimizer"
sudo Disable-ScheduledTask "OmenOverlay"

sudo Disable-ScheduledTask "Microsoft\Windows\Management\Provisioning\Logon" # https://habr.com/ru/news/t/586786/comments/#comment_23656428 https://aka.ms/AAh177w


# screenshot-format=webp
# screenshot-high-bit-depth=no
# screenshot-webp-quality=90


# https://habr.com/ru/news/651217/
# https://learn.microsoft.com/en-us/answers/questions/1076711/install-wmic-to-a-windows-11-computer?orderby=oldest
#  DISM /Online /Add-Capability /CapabilityName:WMIC~~~~ 
#  https://www.google.com/search?client=firefox-b-d&q=+wmic+pagefileset+where+%22Description+%3D+Invalid+query%22
# https://theblownlightbulb.wordpress.com/2012/02/03/fix-description-invalid-query-when-changing-page-file-location-in-windows-server-2008-r2-core/
# https://www.google.com/search?q=windows+powershell+for+wmi&client=firefox-b-d&sxsrf=APwXEdfvN1ePkUCu3uX3kjYy5h63yg3aJQ%3A1682102437779&ved=0ahUKEwingp7yz7v-AhVvwosKHTpBDnEQ4dUDCA4&uact=5&sclient=gws-wiz-serp
# https://learn.microsoft.com/ru-ru/powershell/scripting/learn/ps101/07-working-with-wmi?view=powershell-7.3
# https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/07-working-with-wmi?view=powershell-7.3
# https://www.google.com/search?client=firefox-b-d&q=windows+11+wmic
# https://habr.com/ru/news/651217/
# https://learn.microsoft.com/en-us/answers/questions/1076711/install-wmic-to-a-windows-11-computer?orderby=oldest
# https://www.google.com/search?q=wmic+pagefile+%22No+Instance(s)+Available.%22&client=firefox-b-d&sxsrf=APwXEddvgk-bzlN3xQle0CYDFhYH20DWpw:1682100340365&start=10&ved=2ahUKEwiwj46KyLv-AhVSlYsKHbopCmUQ8NMDegQILBAI
# https://superuser.com/questions/1024034/no-instances-available-error-with-the-wmic-command
# https://www.google.com/search?q=wmic+pagefile+delete+windows+11&client=firefox-b-d&sxsrf=APwXEdcaE0fxyXWL2sqRcj3XyQT54ksn-A%3A1682100528489&ved=0ahUKEwiAmujjyLv-AhVgAxAIHdlADh8Q4dUDCA4&uact=5&sclient=gws-wiz-serp
# https://www.windowscentral.com/software-apps/windows-11/how-to-manage-virtual-memory-on-windows-11
# https://www.theunfolder.com/increase-virtual-memory-windows-11/
# https://www.google.com/search?q=windows+11+command+line+disable+pagefile&client=firefox-b-d&sxsrf=APwXEdd73trDIcPLew0YPxtxGcPIyjb6UA%3A1682099543808&ved=0ahUKEwjQjKSOxbv-AhWuCBAIHXp-AE8Q4dUDCA4&uact=5&sclient=gws-wiz-serp
# https://www.elevenforum.com/t/manage-virtual-memory-paging-file-in-windows-11.8618/
# https://superuser.com/questions/952599/how-to-completely-disable-pagefile-use-wmic
# https://www.reddit.com/r/Windows10HowTo/comments/yj6ve9/delete_pagefilesys_or_reduce_its_size_in_windows/
# https://help.pdq.com/hc/en-us/community/posts/115002970512-Powershell-script-to-change-Pagefile-Virtual-memory-size-on-remote-computers-using-PDQ-deploy-
# https://powershell.one/wmi/root/cimv2/win32_pagefileusage
# https://serverfault.com/questions/558069/use-wmi-to-remove-a-page-file
# https://www.tutorialspoint.com/how-to-change-pagefile-settings-using-powershell
# https://www.powershellgallery.com/packages?q=page+file
# https://www.powershellgallery.com/packages/Carbon/2.13.0
# https://get-carbon.org/documentation.html
# https://github.com/search?q=repo%3Awebmd-health-services%2FCarbon+pagefile&type=issues
# https://www.google.com/search?client=firefox-b-d&q=wmic+pagefileset+where
# https://www.tenforums.com/tutorials/77692-manage-virtual-memory-pagefile-windows-10-a-2.html
# https://github.com/microsoft/Windows-Containers/issues/271
# https://garvis.ca/2018/02/07/change-the-page-in-command-line/
# https://social.technet.microsoft.com/Forums/windows/en-US/708da424-3a7c-404d-8f54-f989ed62d323/command-for-changeing-the-page-file?forum=winservercore
# https://www.itprotoday.com/windows-78/modify-pagefile-configuration-command-line
# https://winnote.ru/instructions/282-upravlenie-faylom-podkachki-pagefilesys-s-pomoschyu-komandnoy-stroki.html


# TODO: test this
sudo wmic computersystem set AutomaticManagedPagefile=False
sudo wmic pagefileset delete
# sudo wmic pagefileset where name="C:\\pagefile.sys" delete


# https://yarnpkg.com/getting-started/install https://nodejs.org/dist/latest/docs/api/corepack.html
#corepack enable --install-directory ~/.local/bin; yarn set version stable


"$HOME\Desktop\Google Docs.lnk", "$HOME\Desktop\Google Sheets.lnk", "$HOME\Desktop\Google Slides.lnk"


# Set-Alias -Name lychee -Value $env:LOCALAPPDATA\Microsoft\WinGet\Packages\lycheeverse.lychee_Microsoft.Winget.Source_8wekyb3d8bbwe\lychee*.exe # https://github.com/microsoft/winget-cli/issues/361 https://github.com/microsoft/winget-cli/issues/2802


# https://thewiki.moe/guides/playback/#smooth-playback
# https://www.reddit.com/r/mpv/comments/su2mee/how_can_i_fix_jittery_video_playback/
# [LFR]
# profile-desc=Fix jitter on panning shots in lfr videos
# profile-cond=p["estimated-vf-fps"] <30
# profile-restore=copy
# video-sync=display-resample


Invoke-WebRequest -Uri "https://haali.net/winutils/lswitch.exe" -OutFile $HOME/lswitch.exe

# codecs
# $user += '9N95Q1ZZPMH4', '9PG2DK419DRG', '9MVZQVXJBQ9V', '9NCTDW2W1BH8', '9PMMSR1CGPWG', '9N5TDP8VCMHS'
# "HEVC -Install"

# sudo choco install -y --pin --ignorechecksum ea-app


# https://winitpro.ru/index.php/2021/12/16/udalit-chat-microsoft-teams-v-windows/ https://www.outsidethebox.ms/21375/ https://aka.ms/AAh4nac
# sudo --ti reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v "ConfigureChatAutoInstall" /t REG_DWORD /d 0 /f


sudo { Disable-ScheduledTask "Achievement Watcher Upgrade Daily" } # https://github.com/Xav83/chocolatey-packages/pull/24
Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Achievement Watcher.lnk" # TODO: https://github.com/Xav83/chocolatey-packages/pull/24


sudo Invoke-WebRequest -Uri "https://gist.github.com/soredake/f0c63deeaf104e30135a28c3238a6008/raw" -OutFile C:\ProgramData\Winget-AutoUpdate\excluded_apps.txt


# https://www.outsidethebox.ms/21985/
sudo reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy' /v 'fMinimizeConnections' /t REG_DWORD /d 0 /f

// https://kb.mozillazine.org/Browser.link.open_newwindow
// spotify "open in desktop app" feature annoyingly opens new tab every time
// user_pref("browser.link.open_newwindow", 1);


iex "& { $(iwr -useb 'https://spotx-official.github.io/run.ps1') } -confirm_spoti_recomended_over -new_theme -enhancesongs -block_update_on -podcasts_on -lyrics_stat spotify -cache_limit 2000"


# 'Microsoft.549981C3F5F10_8wekyb3d8bbwe' - cortana https://support.microsoft.com/en-us/topic/end-of-support-for-cortana-in-windows-d025b39f-ee5b-4836-a954-0ab646ee1efa?ranMID=24542&OCID=AID2200057_aff_7593_1243925 # 'MicrosoftTeams_8wekyb3d8bbwe' # 9MSSGKG348SP # 'BlueStacks` X'

function lycheefix {
  if ($args[0] -eq "off") {
    sudo net start Hamachi2Svc
    sudo {
     netsh interface set interface "ProtonVPN TUN" admin=enable
     netsh interface set interface "Ethernet 2" admin=enable
     netsh interface set interface "VMware Network Adapter VMnet1" admin=enable
      netsh interface set interface "VMware Network Adapter VMnet8" admin=enable
      netsh interface set interface "Подключение по локальной сети" admin=enable
    }
  }
  else {
    sudo net stop Hamachi2Svc
    sudo {
      netsh interface set interface "ProtonVPN TUN" admin=disable
      netsh interface set interface "Ethernet 2" admin=disable
      netsh interface set interface "VMware Network Adapter VMnet1" admin=disable
      netsh interface set interface "VMware Network Adapter VMnet8" admin=disable
      netsh interface set interface "Подключение по локальной сети" admin=disable
      Get-NetAdapter | Disable-NetAdapter -Confirm:$false
      netsh interface set interface "Ethernet 3" admin=enable

    }
  }
}


New-Shortcut -Name 'melonDS' -Path $HOME\Desktop -Target "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\melonDS.melonDS_Microsoft.Winget.Source_8wekyb3d8bbwe\melonDS.exe"

sudo winget install -h -e --id ViGEm.HidHide -v 1.2.98 # https://github.com/ViGEm/HidHide/issues/109 https://github.com/ViGEm/HidHide/issues/110 https://github.com/ViGEm/HidHide/issues/111


Register-ScheduledTask -Principal (New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest) -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" -Argument '--title "AMD cleanup task" pwsh -c amdcleanup') -TaskName "AMD cleanup task" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable) -Trigger (New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Friday -At 11:00)

# RamenSoftware.7+TaskbarTweaker
New-Shortcut -Name 'SteaScree' -Path $HOME\Desktop -Target "${env:ProgramFiles(x86)}\SteaScree\SteaScree.exe"

# WSL1 setup
# New-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss' DefaultVersion -Value 1 -Force
# sudo wsl --install --enable-wsl1 --no-launch

# sudo --ti .\scripts\vbs-disable\vbs-disable.ps1

# function hyperv_toggle {
#   if (((sudo bcdedit /enum) -match 'hypervisorlaunchtype' -replace 'hypervisorlaunchtype    ') -eq 'Off') {
#     write-host("Enabling Hyper-V..."); sudo bcdedit /set hypervisorlaunchtype auto
#   }
#   else {
#     write-host("Disabling Hyper-V..."); sudo bcdedit /set hypervisorlaunchtype off
#   }
# }

# function amdcleanup { Remove-Item C:\AMD\* -Recurse -Force }

# function mpvnetdvd { mpvnet dvd:// --dvd-device=VIDEO_TS }

sudo {
  # DISM /Online /Disable-Feature:Microsoft-Hyper-V-All /NoRestart
  # DISM /Online /Disable-Feature:VirtualMachinePlatform /NoRestart
}


######## lychee lycheeverse.lychee
# https://www.outsidethebox.ms/21985/
# sudo reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy' /v 'fMinimizeConnections' /t REG_DWORD /d 3 /f

# lychee fix
Set-NetIPInterface -InterfaceIndex $env:interfaceIndex -InterfaceMetric 1

# https://github.com/lycheeverse/lychee/issues/902
# https://github.com/hyperium/hyper/issues/3122
function lycheefix {
  $env:interfaceIndex = (Get-NetRoute | Where-Object -FilterScript { $_.DestinationPrefix -eq "0.0.0.0/0" } | Get-NetAdapter).InterfaceIndex
  if ($args[0] -eq "off") {
    sudo net start Hamachi2Svc
    sudo { Get-NetAdapter | Enable-NetAdapter -Confirm:$false }
  }
  else {
    sudo net stop Hamachi2Svc
    sudo { Get-NetAdapter | Disable-NetAdapter -Confirm:$false
      Get-NetAdapter -InterfaceIndex $env:interfaceIndex | Enable-NetAdapter }
  }
}

# function checkarchive { lycheefix; cd "$HOME\Мой диск\документы"; lychee --exclude='vk.com' --exclude='yandex.ru' --max-concurrency 10 archive-org.txt; lycheefix off }
# function checklinux { lycheefix; cd "$HOME\Мой диск\документы"; lychee --max-concurrency 10 linux.txt; lycheefix off }



# sudo Enable-ComputerRestore -Drive $env:SystemDrive

# https://github.com/chocolatey/choco/issues/1465
#sudo choco feature enable -n=useRememberedArgumentsForUpgrades -n=removePackageInformationOnUninstall

sudo winget install --no-upgrade -h --accept-package-agreements --accept-source-agreements -e --id Oracle.VirtualBox -v 6.1.48


# stop qbittorrent/ethernet from waking my pc from sleep https://superuser.com/a/1629820/1506333 https://superuser.com/a/1320579 https://aka.ms/AAkvx4s
# sudo { powercfg /devicedisablewake "Intel(R) I211 Gigabit Network Connection #2" }


# New-Shortcut -Name 'Disconnect gamepad' -Path $HOME\Desktop -Target "C:\Program Files\DS4Windows\DS4Windows.exe" -Arguments "-command Disconnect" -IconPath "C:\Program Files\DS4Windows\DS4Windows.exe"
# New-Shortcut -Name 'Cheat Engine' -Path $HOME\Desktop -Target "$HOME\scoop\apps\cheat-engine\current\cheatengine-x86_64.exe"
# New-Shortcut -Name 'PPSSPP' -Path $HOME\Desktop -Target "$env:ProgramFiles\PPSSPP\PPSSPPWindows64.exe"
# New-Shortcut -Name 'yuzu Early Access' -Path $HOME\Desktop -Target "$HOME\scoop\apps\yuzu-pineapple\current\yuzu.exe"

# Install-PackageProvider -Name NuGet -Scope CurrentUser -Confirm:$false -Force

# disable hibernation
sudo powercfg /h off

  # http://war2.ru/modules/newbb_plus/viewtopic.php?topic_id=1882&forum=1
  # https://www.ru.playblackdesert.com/Community/Detail?topicNo=45670&topicType=101#
  $env:interfaceGuid = (Get-NetAdapter | Where-Object { $_.InterfaceDescription -like 'Intel(R) I211*' } | Select-Object -Property InterfaceGuid).InterfaceGuid
  sudo { reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$env:interfaceGuid" /v 'TcpAckFrequency' /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$env:interfaceGuid" /v 'TCPNoDelay' /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$env:interfaceGuid" /v 'TcpDelAckTicks' /t REG_DWORD /d 0 /f
    reg add 'HKLM\SOFTWARE\Microsoft\MSMQ\Parameters' /v 'TCPNoDelay' /t REG_DWORD /d 1 /f }


 # Create the archive with LZMA compression
  7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "$HOME\Мой диск\документы\backups\syncthing\syncthing.7z" "$env:LOCALAPPDATA\Syncthing"

# https://winaero.com/change-icon-cache-size-windows-10/ https://www.elevenforum.com/t/change-icon-cache-size-in-windows-11.2050/
# sudo { reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' /v MaxCachedIcons /t REG_SZ /d 65535 /f }

# refreshenv # https://github.com/microsoft/winget-cli/issues/3077 https://github.com/chocolatey/choco/issues/2458

# prefer 7zip from winget
# scoop shim rm 7zG 7z 7zfm

# trakts config set players.monitored mpv syncplay@mpv
# trakts config set fileinfo.whitelist E:\non-anime E:\shared-unruhe E:\shared-tablet
# trakts config set players.mpv.ipc_path '\\.\pipe\mpvsocket'

# https://learn.microsoft.com/en-us/powershell/scripting/learn/experimental-features?view=powershell-7.4
# Enable-ExperimentalFeature -Name PSCommandNotFoundSuggestion

# sudo { irm https://community.chocolatey.org/install.ps1 -useb | iex }
# Get-ChildItem -Path "C:\ProgramData\chocolatey\helpers\functions" -Filter *.ps1 | ForEach-Object { . $_.FullName }
# refreshenv

# Remove-Item -Recurse -Path ~\Downloads\Sophia*

# https://www.outsidethebox.ms/9961/#default-state https://aka.ms/AAns3an
# sudo Enable-ComputerRestore -Drive $env:SystemDrive

# disable pwsh update check https://github.com/PowerShell/PowerShell/issues/19528 https://github.com/PowerShell/PowerShell/issues/19520 https://github.com/PowerShell/PowerShell/issues/20210 https://github.com/PowerShell/PowerShell/issues/20833
#setx POWERSHELL_UPDATECHECK Off

            {
                "colorScheme": "Tango+Solarized dark",
                "commandline": "C:/tools/msys64/msys2_shell.cmd -defterm -no-start -mingw64 -use-full-path -here -shell zsh",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "icon": "C:\\tools\\msys64\\msys2.ico",
                "name": "MSYS2/zsh",
                "tabTitle": "MSYS2/zsh"
            },

                        {
                "closeOnExit": "graceful",
                "commandline": "\"%PROGRAMFILES%\\git\\bin\\bash.exe\" --login -i -l",
                "cursorColor": "#FFFFFF",
                "guid": "{00000000-0000-0000-0000-000000012345}",
                "historySize": 9001,
                "icon": "%PROGRAMFILES%\\git\\mingw64\\share\\git\\git-for-windows.ico",
                "name": "Git Bash",
                "snapOnInput": true
            },


# fix protonvpn "Unable to add IPv6 leak protection connection/interface" https://github.com/ProtonVPN/linux-app/issues/46#issuecomment-932239261
# sudo apt-get install -y policykit-1-gnome
# echo "[nm-applet]
# Identity=unix-user:ubuntu
# Action=org.freedesktop.NetworkManager.*
# ResultAny=yes
# ResultInactive=no
# ResultActive=yes" | sudo tee /etc/polkit-1/localauthority/50-local.d/org.freedesktop.NetworkManager.pkla

# lychee
export lycheever=0.13.0
wget https://github.com/lycheeverse/lychee/releases/download/v${lycheever}/lychee-v${lycheever}-x86_64-unknown-linux-gnu.tar.gz
tar -xvzf lychee-v${lycheever}-x86_64-unknown-linux-gnu.tar.gz
mv lychee ~/.local/bin
rm -f lychee-v${lycheever}-x86_64-unknown-linux-gnu.tar.gz
chmod +x ~/.local/bin/lychee


# sudo add-apt-repository -y ppa:fish-shell/release-3
#deb=protonvpn-stable-release_1.0.3_all.deb
#sudo wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/$deb
#sudo apt-get install ./$deb
# sudo apt install protonvpn-cli


reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f

curl -L --create-dirs --remote-name-all --output-dir $env:APPDATA\mpv.net\scripts "https://raw.githubusercontent.com/fbriere/mpv-scripts/master/scripts/tree-profiles.lua" "https://raw.githubusercontent.com/fbriere/mpv-scripts/master/scripts/brace-expand.lua"

# https://github.com/TairikuOokami/Windows/blob/a778fff230d348906f999ad1380e326c43a7f1bc/Windows%20Tweaks.bat#L1639-L1640
# sudo reg add "HKLM\Software\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d "0" /f

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All, VirtualMachinePlatform

# function checkarchivewindows { cd "$HOME\Мой диск\документы"; oracleproxy lychee --exclude='vk.com' --exclude='yandex.ru' --max-concurrency 10 archive-org.txt }
# function checklinuxwindows { cd "$HOME\Мой диск\документы"; oracleproxy lychee --max-concurrency 10 linux.txt }

# function checkarchive { wsl --shell-type login -- lychee --exclude='vk.com' --exclude='yandex.ru' --max-concurrency 10 /mnt/c/Users/$env:USERNAME/Мой` диск/документы/archive-org.txt }
# function checklinux { wsl --shell-type login -- lychee --exclude='vk.com' --exclude='yandex.ru' --max-concurrency 10 /mnt/c/Users/$env:USERNAME/Мой` диск/документы/linux.txt }

# sudo chsh -s /usr/bin/fish "$USER"
# echo -e "eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)\nfish_add_path $HOME/.local/bin \nalias upall 'sudo apt update; sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y; pipx upgrade-all; brew update && brew upgrade && brew cleanup'" >>~/.config/fish/config.fish
# echo 'echo -en "\e[6 q"' >>~/.config/fish/config.fish # no cursor blinking https://github.com/microsoft/terminal/issues/1379#issuecomment-821825557 https://github.com/fish-shell/fish-shell/issues/3741#issuecomment-273209823
# sudo snap set system refresh.retain=2 # already set to 2 https://snapcraft.io/docs/managing-updates#heading--refresh-retain
# https://github.com/flatpak/flatpak/issues/4484 https://github.com/flatpak/flatpak/issues/2267
#sudo rm -rf /dev/shm; sudo mkdir /dev/shm

# # https://github.com/MicrosoftDocs/windows-itpro-docs/blob/fa1414a7716f274200e9b7829124b2afac29ac20/windows/application-management/provisioned-apps-windows-client-os.md
Get-AppxPackage | ForEach-Object { $pkg = $_; Get-StartApps | Where-Object { $_.AppID -like "*$($pkg.PackageFamilyName)*" } | ForEach-Object { New-Object PSObject -Property @{PackageFamilyName=$pkg.PackageFullName; AppName=$_.Name} } } | Format-Table -AutoSize | Out-File -FilePath .\AppList.txt

oh-my-posh font install --user Hack

sudo { reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' /v 'DisableAntiSpyware' /t REG_DWORD /d 1 /f
  reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' /v 'ServiceKeepAlive' /t REG_DWORD /d 0 /f
  Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend }

setx PIPX_BIN_DIR $HOME\scoop\persist\python310\Scripts


function multipassmountfix {
  # temp fix until 1.13.0 arrive https://github.com/canonical/multipass/issues/3252
  multipass mount C:\ primary:/mnt/c_host
  multipass mount D:\ primary:/mnt/d_host
  multipass mount E:\ primary:/mnt/e_host
}

New-Shortcut -Name 'Ryujinx' -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs" -Target (where.exe Ryujinx.Ava.exe) # install it from choco again when avalonia is merged https://github.com/Ryujinx/Ryujinx/issues/3662
New-Shortcut -Name 'WinSetView' -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs" -Target (where.exe WinSetView)

function github-backup { python (where.exe github-backup) $args } # https://github.com/josegonzalez/python-github-backup/issues/112
pip install github-backup

 sudo bash -c \'docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>" | xargs -L1 docker pull\''


# function upgradeall {
#   # https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/automatically-updating-modules https://github.com/PowerShell/PSResourceGet/issues/521 https://github.com/PowerShell/PSResourceGet/issues/495
#   Get-InstalledModule | Update-Module
#   # https://www.activestate.com/resources/quick-reads/how-to-update-all-python-packages/ https://github.com/pypa/pip/issues/4551
#   pip freeze | % { $_.split('==')[0] } | % { pip install --upgrade $_ }
#   pipx upgrade-all
#   npm update -g
#   scoop update -a
#   scoop cleanup -ka
#   psc update *
# }


  # Get-ChildItem -Path "$HOME\Мой диск\unsorted" -Recurse -File | Move-Item -Destination "$HOME\Мой диск"
  gci "$HOME\Мой диск\unsorted" -Recurse -File | % { $destFile = "$HOME\Мой диск\$($_.Name)"; while (Test-Path $destFile) { $destFile = "$HOME\Мой диск\$([System.IO.Path]::GetFileNameWithoutExtension($_.Name))_$((Get-Random -Maximum 9999))$([System.IO.Path]::GetExtension($_.Name))" }; mv $_.FullName $destFile }
  # rclone sync -P $env:APPDATA\VolumeLock "$HOME\Мой диск\документы\backups\volumelock"


# Get-ChildItem -Path "C:\ProgramData\chocolatey\helpers\functions" -Filter *.ps1 | ForEach-Object { . $_.FullName }; refreshenv

# TODO: FileNotFoundError: [WinError 2] The system cannot find the file specified
curl -L -o C:\Users\user\AppData\Local\Programs\Python\Python312\Scripts\OpenSubtitlesDownload.py "https://raw.githubusercontent.com/emericg/OpenSubtitlesDownload/master/OpenSubtitlesDownload.py"

  # backup task
  Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" -Argument "--title Backup pwsh -c backup") -TaskName "Backup everything" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Weekly -At 13:00 -DaysOfWeek 3)

  # upgrade task
  Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" -Argument '--title "Upgrade everything" pwsh -c upgradeall') -TaskName "Upgrade everything" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday -At 12:00)

  # workaround for https://github.com/lycheeverse/lychee/issues/902 and https://github.com/hyperium/hyper/issues/3122
  #schtasks /Create /SC ONLOGON /TN "RestartHamachi" /TR "powershell.exe -WindowStyle Hidden -Command 'Start-Sleep -Seconds 900; Restart-Service -Name Hamachi2Svc'" /RL HIGHEST

# function checkarchivemultipass { multipass exec primary -- /home/linuxbrew/.linuxbrew/bin/lychee --exclude='vk.com' --exclude='yandex.ru' --exclude='megaten.ru' --max-concurrency 5 /mnt/c_host/Users/$env:USERNAME/Мой` диск/документы/archive-org.txt; mps }
# function checklinuxmultipass { multipass exec primary -- /home/linuxbrew/.linuxbrew/bin/lychee --exclude='vk.com' --exclude='yandex.ru' --exclude='megaten.ru' --max-concurrency 5 /mnt/c_host/Users/$env:USERNAME/Мой` диск/документы/linux.txt; mps }

  # Invoke-WebRequest -Uri "https://github.com/Romanitho/Winget-AutoUpdate/archive/refs/heads/main.zip" -OutFile "$HOME/Downloads/Winget-AutoUpdate.zip"
  # Expand-Archive "$HOME/Downloads/Winget-AutoUpdate.zip" -DestinationPath "$HOME/Downloads"

# wsl --manage Ubuntu-22.04 --set-sparse true


# installing patched spotify
# Invoke-Expression "& { $(Invoke-WebRequest -useb 'https://spotx-official.github.io/run.ps1') } -confirm_spoti_recomended_over -new_theme -block_update_on -podcasts_on"


# CommandNotFound https://learn.microsoft.com/en-us/windows/powertoys/cmd-not-found https://github.com/microsoft/PowerToys/issues/30818
Install-Module -Name Microsoft.WinGet.Client
Enable-ExperimentalFeature -Name PSFeedbackProvider, PSCommandNotFoundSuggestion
Import-Module $env:ProgramFiles\PowerToys\WinGetCommandNotFound.psd1


# latest wsl2 kernel
# curl -L -o $HOME\wsl2-xanmod-kernel "https://github.com/soredake/xanmod-kernel-WSL2/releases/download/6.7.7-locietta-WSL2-xanmod1.1/bzImage"

# not working on windows 11
scoop install caffeine

  # Caffeine startup task
  $trigger = New-ScheduledTaskTrigger -AtLogon
  $trigger.Delay = 'PT5M'
  Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$HOME\scoop\apps\caffeine\current\caffeine64.exe" -Argument "-allowss -startoff") -TaskName "Caffeine" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -ExecutionTimeLimit 0 -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)) -Trigger $trigger

  # works, blocks sleep but allows screen to turn off
  choco install -y insomnia

function reboottobios { shutdown /r /fw /f /t 0 }

# Workaround for https://github.com/erengy/taiga/issues/1151#issuecomment-1761431682
taskkill /im Taiga.exe
Start-Sleep -Seconds 30
# https://taiga.moe/latest.html
curl -L -o $env:APPDATA\Taiga\Taiga.exe "https://taiga.moe/latest.php"

# File is not existing by default
winget settings
# Fix for winget downloading speed https://github.com/microsoft/winget-cli/issues/2124
($settings = Get-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json) | ForEach-Object { if ($_.network -eq $null) { $_ | Add-Member -MemberType NoteProperty -Name 'network' -Value (New-Object PSObject) -Force }; $_.network | Add-Member -MemberType NoteProperty -Name 'downloader' -Value 'wininet' -Force }; $settings | ConvertTo-Json | Set-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
# https://github.com/microsoft/winget-cli/discussions/4281
# https://github.com/microsoft/winget-cli/releases/tag/v1.8.924-preview
($settings = Get-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json) | ForEach-Object { if ($_.experimentalFeatures -eq $null) { $_ | Add-Member -MemberType NoteProperty -Name 'experimentalFeatures' -Value (New-Object PSObject) -Force }; $_.experimentalFeatures | Add-Member -MemberType NoteProperty -Name 'sideBySide' -Value $true -Force }; $settings | ConvertTo-Json | Set-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"


  # I don't need defender https://remontka.pro/windows-defender-turn-off/
  # Why i disabled defender: https://github.com/microsoft/winget-cli/issues/3505#issuecomment-1666813120 https://github.com/ScoopInstaller/Scoop/wiki/Antivirus-and-Anti-Malware-Problems https://github.com/microsoft/WSL/issues/8995 https://github.com/microsoft/WSL/issues/1932
  # TODO: https://github.com/microsoft/devhome/issues/1983#issuecomment-1837182515
  reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' /v DisableAntiSpyware /t REG_DWORD /d 1 /f
  reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' /v ServiceKeepAlive /t REG_DWORD /d 0 /f
  # reg add 'HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet' /v SubmitSamplesConsent /t REG_DWORD /d 0 /f
  reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection' /v DisableIOAVProtection /t REG_DWORD /d 1 /f
  reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection' /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f


# https://remontka.pro/wake-timers-windows/
# https://winaero.com/windows-11-may-soon-install-monthly-updates-without-a-reboot/
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 0

#setx PIPX_BIN_DIR $env:LOCALAPPDATA\Programs\Python\Python312\Scripts

# Configuring scoop to use NanaZip
#scoop config use_external_7zip true
#scoop install 7zip


  # Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe" -Argument "$HOME\git\dotfiles_windows\scripts\restart-qbittorrent.ps1") -TaskName "Restart qBittorrent every day" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Daily -At 09:00)


  Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe" -Argument "$HOME\git\dotfiles_windows\scripts\restart-taiga.ps1") -TaskName "Restart Taiga every day" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Daily -At 09:00)


  Add-MpPreference -ExclusionExtension ".cbz", ".cbr", ".jpeg", ".jpg", ".png", ".webp", ".avif", ".jxl", ".gif", ".mp3", ".flac", ".ogg", ".wav", ".mkv", ".avi", ".mp4", ".m4v", ".mpg", ".ts", ".webm", ".parts", ".ass", ".srt", ".vhd", ".vhdx", ".vdi", ".vmdk", ".xci", ".nca", ".nsp", ".torrents"

npm install --global nightlight-cli

  # Night Light is usually not turned off automatically in the morning https://aka.ms/AAqoje8 TODO: this cli tool is not working most of the times
  # Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe -c nightlight off") -TaskName "Turning off the night light in the morning" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable) -Trigger (New-ScheduledTaskTrigger -Daily -At 08:00)

#psc config update 0
#psc config module_update 0

# CompletionPredictor is breaks PSCompletions https://github.com/PowerShell/CompletionPredictor/issues/37
# PSCompletions is no longer installed as I don't use it, and it adds 2-3 seconds to load delay
#psc add npm winget scoop
psc update *

# https://github.com/PowerShell/CompletionPredictor?tab=readme-ov-file#use-the-predictor
#Set-PSReadLineOption -PredictionSource HistoryAndPlugin

  # OneDrive can't backup symlinks
  # NOTE: seems to be fixed now
  #New-Item -ItemType HardLink -Path "$documentsPath\PowerShell\Profile.ps1" -Target "$HOME\git\dotfiles_windows\dotfiles\Documents\PowerShell\Profile.ps1"

  # Start plex-mpv-shim at logon
  # https://github.com/iwalton3/plex-mpv-shim/issues/118
  #Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe -c Start-Sleep -Seconds 120 && Start-Process -FilePath $HOME\scoop\apps\plex-mpv-shim\current\run.exe -WorkingDirectory $HOME\scoop\apps\plex-mpv-shim\current") -TaskName "plex-mpv-shim" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -ExecutionTimeLimit 0 -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)) -Trigger (New-ScheduledTaskTrigger -AtLogon)

  # Start Plex For Windows at logon
  # https://forums.plex.tv/t/add-autostart-on-logon-option-to-plex-for-windows/880558
  #Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "$env:ProgramFiles\Plex\Plex\Plex.exe" -WorkingDirectory "$env:ProgramFiles\Plex\Plex") -TaskName "Plex For Windows" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable) -Trigger (New-ScheduledTaskTrigger -AtLogon)


# yoink installation
$archivePath = "$HOME/Downloads/yoink_windows_amd64.zip"
$desiredFilePath = "$HOME/yoink.exe"
$tempDir = "$HOME/Downloads/yoink/"
Invoke-WebRequest -Uri "https://github.com/MrMarble/yoink/releases/download/v0.5.0/yoink_windows_amd64.zip" -OutFile "$HOME/Downloads/yoink_windows_amd64.zip"
New-Item -ItemType Directory -Path $tempDir -Force
Expand-Archive -Path $archivePath -DestinationPath $tempDir
$extractedFilePath = Join-Path -Path $tempDir -ChildPath "yoink.exe"
Move-Item -Path $extractedFilePath -Destination $desiredFilePath
Remove-Item -Path $tempDir -Recurse -Force

  # This package is unmaintained and now (18.07.2024) is broken, I now update chocolatey packages with topgrade
  # choco install -y choco-upgrade-all-at --params "'/WEEKLY:yes /DAY:SUN /TIME:10:00'"

  # https://www.elevenforum.com/t/change-automatic-maintenance-time-in-windows-11.16687/
  #reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "Activation Boundary" /t REG_SZ /d "2001-01-01T08:00:00" /f


# Task for restarting Plex For Windows and plex-mpv-shim after waking pc from sleep or logon
sudo {
  Unregister-ScheduledTask -TaskName "Restarting plex for windows and plex-mpv-shim" -Confirm:$false
  # https://stackoverflow.com/a/67123362
  # https://learn.microsoft.com/en-us/answers/questions/794854/run-a-program-every-time-the-computer-comes-out-of
  # Create list of triggers, including AtLogOn and custom event trigger
  $triggers = @(New-ScheduledTaskTrigger -AtLogOn)

  # Define custom event trigger
  $subscription = @"
<QueryList><Query Id="0" Path="System"><Select Path="System">*[System[Provider[@Name='Microsoft-Windows-Power-Troubleshooter'] and EventID=1]]</Select></Query></QueryList>
"@

  # Register the custom event trigger using CIM
  $CIMTriggerClass = Get-CimClass -ClassName MSFT_TaskEventTrigger -Namespace Root/Microsoft/Windows/TaskScheduler
  $trigger = New-CimInstance -CimClass $CIMTriggerClass -ClientOnly
  $trigger.Subscription = $subscription
  $trigger.Enabled = $true
  $triggers += $trigger

  # Register the scheduled task
  Register-ScheduledTask -Principal (New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest) -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe $HOME\git\dotfiles_windows\scripts\restart-plex-player-and-shim.ps1") -TaskName "Restarting plex for windows and plex-mpv-shim" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable) -Trigger $triggers
}


# rclone sync -P $env:LOCALAPPDATA\Plex "$HOME\Мой диск\документы\backups\plex" --delete-excluded --exclude "cache/updates/"


  # Winget-AutoUpdate installation
  # NOTE: https://github.com/Romanitho/Winget-AutoUpdate/issues/625
  git clone --depth=1 "https://github.com/Romanitho/Winget-AutoUpdate" "$HOME/Downloads/Winget-AutoUpdate"
  ~\Downloads\Winget-AutoUpdate\Sources\WAU\Winget-AutoUpdate-Install.ps1 -StartMenuShortcut -Silent -InstallUserContext -NotificationLevel Full -UpdatesInterval BiDaily -DoNotUpdate -UpdatesAtTime 11AM
  Remove-Item -Path C:\ProgramData\Winget-AutoUpdate\excluded_apps.txt

  # Task for restarting qBittorrent every day until https://github.com/qbittorrent/qBittorrent/issues/20305 is fixed
  Unregister-ScheduledTask -TaskName "Restart qBittorrent every day" -Confirm:$false
  Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute (where.exe run-hidden.exe) -Argument "$env:LOCALAPPDATA\Microsoft\WindowsApps\pwsh.exe -File $HOME\git\dotfiles_windows\scripts\restart-qbittorrent.ps1") -TaskName "Restart qBittorrent every day" -Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable) -Trigger (New-ScheduledTaskTrigger -Daily -At 09:00), (New-ScheduledTaskTrigger -Daily -At 16:00)


# Games and emulators
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\backups\Playnite.7z" "$env:APPDATA\Playnite" -xr!'Playnite\library\files\*' -xr!'Playnite\browsercache\*'
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\RPCS3.7z" $env:ChocolateyToolsLocation\RPCS3\dev_hdd0\home\00000001\savedata
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\EMPRESS.7z" "$env:PUBLIC\Documents\EMPRESS"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\OnlineFix.7z" "$env:PUBLIC\Documents\OnlineFix"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\CODEX.7z" "$env:PUBLIC\Documents\Steam\CODEX"
# 7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\PPSSPP.7z" "$documentsPath\PPSSPP"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\GoldbergSteamEmuSaves.7z" "$env:APPDATA\Goldberg SteamEmu Saves"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\ryujinx.7z" "$HOME\scoop\persist\ryujinx\portable\bis\user\save"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\saves\sudachi.7z" "$HOME\scoop\apps\sudachi\current\user\nand\user\save"
# https://github.com/Abd-007/Switch-Emulators-Guide/blob/main/Yuzu.md https://github.com/Abd-007/Switch-Emulators-Guide/blob/main/Ryujinx.md
rclone sync -P $HOME\scoop\apps\sudachi\current\user\nand\system\save\8000000000000010\su\avators\profiles.dat "$HOME\Мой диск\документы\backups\sudachi"
rclone sync -P $HOME\scoop\persist\ryujinx\portable\system\Profiles.json "$HOME\Мой диск\документы\backups\ryujinx"


7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\backups\plex.7z" "$env:LOCALAPPDATA\Plex" -xr!'Plex\cache\updates\*'
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\backups\AIMP.7z" "$env:APPDATA\AIMP" -xr!'AIMP\UpdateInstaller.exe'

#7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=9 "$HOME\Мой диск\документы\backups\64gram.7z" "$env:APPDATA\64Gram Desktop\tdata" -xr!'tdata\user_data\media_cache' -xr!'tdata\user_data#2\media_cache' -xr!'tdata\user_data#3\media_cache'

rclone sync -P $env:APPDATA\Taiga\data "$HOME\Мой диск\документы\backups\Taiga" --delete-excluded --exclude "db/image/" --exclude "theme/"
7z a -up0q0r2x2y2z1w2 -t7z -m0=lzma2 -mmt=16 -mx=5 "$HOME\Мой диск\документы\backups\Windhawk.7z" "C:\ProgramData\Windhawk"

# Software needs to be stopped to correctly backup it's data
#taskkill /T /f /im run.exe
# taskkill /T /f /im plex.exe
taskkill /T /f /im "Plex Media Server.exe"
taskkill /T /im Playnite.DesktopApp.exe
taskkill /T /im AIMP.exe
taskkill /T /f /im windhawk.exe

# Starting killed software back
Start-Process -FilePath "$env:ProgramFiles\Plex\Plex Media Server\Plex Media Server.exe" -WindowStyle Hidden
Start-Process -FilePath "$env:ProgramFiles\Windhawk\windhawk.exe" -WorkingDirectory "$env:ProgramFiles\Windhawk"
Start-Process -FilePath "$env:ProgramFiles\AIMP\AIMP.exe"
Start-Sleep -Seconds 5
nircmd win close title Windhawk
#Start-Sleep -Seconds 30
#Start-Process -FilePath $HOME\scoop\apps\plex-mpv-shim\current\run.exe -WorkingDirectory $HOME\scoop\apps\plex-mpv-shim\current
#Start-Sleep -Seconds 30
# NOTE: Plex For Windows cannot started minimized
# NOTE: Plex For Windows needs to be started as admin to avoid UAC prompt https://www.reddit.com/r/PleX/comments/q8un5s/is_there_any_way_to_stop_plex_from_trying_to/
#Start-Process -FilePath "$env:ProgramFiles\Plex\Plex\Plex.exe" -Verb RunAs
#Start-Sleep -Seconds 5
#nircmd win min process Plex.exe
# Workaround for https://github.com/iamkroot/trakt-scrobbler/issues/305
#trakts start --restart



  # NOTE: no longer needed after 5.0.1 https://www.qbittorrent.org/news#mon-oct-28th-2024---qbittorrent-v5.0.1-release
  # Edit qbittorrent shortcut to fix https://github.com/qbittorrent/qBittorrent/issues/21423
  # https://github.com/qbittorrent/qBittorrent/issues/21423#issuecomment-2383875303
  $shortcutPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\qBittorrent\qBittorrent.lnk"
  $WScriptShell = New-Object -ComObject WScript.Shell
  $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
  $shortcut.TargetPath = $shortcut.TargetPath
  $shortcut.Arguments = "-style WindowsVista"
  $shortcut.Save()
  # And autostart entry
  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v qBittorrent /t REG_SZ /d '"C:\Program Files\qBittorrent\qbittorrent.exe" "--profile=" "--configuration=" "--style=WindowsVista"' /f


  # Set hibernation timeout to 13 hours
  # https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/powercfg-command-line-options#change-or-x
  # NOTE: this is needed only when hypervisor boot is enabled
  #powercfg /change /hibernate-timeout-ac 780
  #powercfg /change /hibernate-timeout-dc 780


# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# brew install lychee


rclone sync -P "${env:ProgramFiles(x86)}\MSI Afterburner\Profiles" "$HOME\Мой диск\документы\backups\msi_afterburner"
rclone sync -P "${env:ProgramFiles(x86)}\RivaTuner Statistics Server\Profiles" "$HOME\Мой диск\документы\backups\rtss"
reg export "HKEY_LOCAL_MACHINE\Software\Icaros" "$HOME\Мой диск\документы\backups\xanashi_icaros\xanashi_icaros_HKLM.reg" /y
reg export "HKEY_CURRENT_USER\Software\Icaros" "$HOME\Мой диск\документы\backups\xanashi_icaros\xanashi_icaros_HKCU.reg" /y
