# play all in mpv
function mpa
  if test -d "${PWD}/VIDEO_TS" || test -d "${PWD}/BDMV"; then
    mpv "${PWD}"
  else
    files=( $(ls -b *.{mp4,mkv,webm,avi,wmv} &>/dev/null) )
    mpv "${PWD}"/"${1:-${files[@]}}" "$2"
  fi
end

# Create a new directory and enter it.
# In oh-my-zsh take function is identical to this
function mkd
  mkdir -p "$@" && cd "$_" || exit 1;
end

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
end

# Convert currencies; cconv {amount} {from} {to}
function cconv
  curl -k --socks5-hostname 127.0.0.1:9250 -s "https://www.google.com/finance/converter?a=$1&from=$2&to=$3&hl=es" | sed '/res/!d;s/<[^>]*>//g';
end

# Upload to transfer.sh
function transfer
  if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
             tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> "$tmpfile"; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> "$tmpfile" ; fi; cat "$tmpfile"; rm -f "$tmpfile"
end

# Background with log
# https://github.com/mpv-player/mpv/issues/1377#issuecomment-90370504
function bkg
  logfile=$(mktemp -t "$(basename $1)"-"$(date +%d.%m.%G-%T)"-XXX.log)
  nohup "$@" &>"$logfile" &
end

function wttr
  curl -A curl -k https://wttr.in/"${1}"?lang=ru
end

# Calculate actual size of {HD,SD}; actualsize {size} {gb}[optional, use gigabytes instead of terabytes]
# http://www.sevenforums.com/hardware-devices/23890-hdds-advertized-size-vs-actual-size.html
function actualsize
  if [[ "$2" == gb ]]; then a="0.9313226"; else a="0.9094947"; fi
  echo 'Actual size is:' "$(bc -l <<< "$1 * $a")"
end

# Calculate ppi; ppicalc {widght} {height} {display size[eg 27]}
# http://isthisretina.com/
# https://en.wikipedia.org/wiki/Pixel_density#Calculation_of_monitor_PPI
function ppicalc
  echo 'PPI is:' "$(bc <<< "sqrt($1^2+$2^2)/$3")"
end

# 5gb max
# stores for 90 days
function lewdse
   if [[ "$1" =~ ^https?://.*$ ]]; then local prefix="curl -L --socks5-hostname 127.0.0.1:9250 ${1}"; else local suffix="${1}"; fi
   # eval or sh -c
   sh -c "${prefix:-true}" | curl  -L --progress-bar --socks5-hostname 127.0.0.1:9250 -F name="${2:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1 | grep -i '[a-zA-Z0-9]').${1##*.}}" -F file=@"${suffix:--}" https://lewd.se/api.php?d=upload-tool
end

# Validate tar archives
function tarval
  tar -tJf "$@" >/dev/null
end

# Automatically cd to the directory you were in when quitting ranger if you haven't already:
function ranger
    tempfile="$(mktemp -t ranger-tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
end

# Algorithm borrowed from http://wiki.rtorrent.org/MagnetUri and adapted to work with zsh.
# Copied from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/torrent/torrent.plugin.zsh
function magnet_to_torrent
  [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
  hashh=${match[1]}
  if [[ "$1" =~ dn=([^\&/]+) ]]; then
    filename=${match[1]}
  else
    filename=$hashh
  fi
  echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
end

function px
  if type -t g >/dev/null ^/dev/null
    set _command (type $argv | grep -o ".*\$argv" | sed 's/\$argv//g')
  else
    set _command $argv[1]
  end
  proxychains -q $_command $argv[2..(count $argv)]
end

# upgrade currently selected kernel
function kernelup
  sudo genkernel --cachedir=/var/tmp/portage --tempdir=/var/tmp/portage --install --udev --virtio --postclear --no-save-config --clean --no-lvm --no-mdadm --no-dmraid --zfs --no-btrfs --no-iscsi --no-luks --no-netboot --mountboot --makeopts=-j(nproc) --ramdisk-modules --kernel-config="$HOME/git/dotfiles_home/kernel/.config" "${@:-all}"
end

function j
  case $argv in
    g) cd $HOME/git ;;
    s) cd $HOME/sync ;;
    t) cd /media/disk0/torrents ;;
    gd) cd $HOME/sync/main/Documents/googledocs ;;
    dch) cd $HOME/sync/main/Documents/dollchan ;;
    b) cd $HOME/sync/main/Documents/bookmarks ;;
    bak) cd $HOME/sync/system-data ;;
    m) cd $HOME/media ;;
    *) echo "No folder defined for this alias." ;;
  esac
end

function g -w git
  git $argv
end

function mus -w mpv
  mpv --profile=novid $argv
end

function egrep -w grep
  grep -E --color $argv
end

function grep -w grep
  grep --color $argv
end

function e -w atom
  atom $argv
end

function startvm
  sudo chmod 777 /dev/kvm
  sudo cpupower frequency-set -g performance
  sudo virsh start win10
end

function stopvm
  sudo virsh stop win10
  sudo cpupower frequency-set -g ondemand
end

function passtovm
  sed -i "s/amdgpu//g" $(realpath /etc/modules-load.d/modules.conf)
  sudo tee -a /etc/modules-load.d/vfio.conf <<END
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
END
  sudo tee -a /etc/modprobe.d/vfio-pci.conf <<< "options vfio-pci ids=1002:67ff,1002:aae0"
end

function backtohost
  tee -a /etc/modules-load.d/modules.conf <<< "amdgpu"
  sudo rm -f /etc/modules-load.d/vfio.conf /etc/modprobe.d/vfio-pci.conf
end

# https://gist.github.com/shamil/62935d9b456a6f9877b5
function vm-mount-parts
  sudo qemu-nbd --connect=/dev/nbd0 /var/lib/libvirt/images/win10.qcow2
  sudo qemu-nbd --connect=/dev/nbd1 /var/lib/libvirt/images/win10-1.qcow2
  sudo qemu-nbd --connect=/dev/nbd2 /var/lib/libvirt/images/win10-2.qcow2
  sleep 3
  sudo mount /dev/nbd0p4 "$HOME/media/vm-disk-c"
  sudo mount /dev/nbd1p2 "$HOME/media/vm-disk-f"
  sudo mount /dev/nbd2p2 "$HOME/media/vm-disk-g"
end

function vm-unmount-parts
  sudo umount "$HOME/media/vm-disk-c"
  sudo umount "$HOME/media/vm-disk-f"
  sudo umount "$HOME/media/vm-disk-g"
  qemu-nbd --disconnect /dev/nbd0p4
  qemu-nbd --disconnect /dev/nbd1p2
  qemu-nbd --disconnect /dev/nbd2p2
end
