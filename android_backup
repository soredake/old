#!/bin/bash
# shellcheck disable=SC2016
# shellcheck disable=SC2162

method=mtp
export IGNORE='.nomedia'
rmv() { rsync --exclude=$IGNORE -q --archive --acls --xattrs --compress --progress --verbose -h --remove-source-files "$@"; }
mtp() { echo "Mounting storage with mtp"
  export b="$HOME/media/android"
  aft-mtp-mount "$b"
  export fmtp="${b}/Внутренний общий накопитель"
}
sshs() { adb start-server
  read -p "Android ip? " ip
  if adb get-state | grep --quiet unknown; then
    echo "not connected, establishing connection"
    if adb devices -l | grep --quiet usb; then
      echo "found usb connection, using it"
    else
      echo "no usb, using wireless connection"
      read -p "Android port? " port
      adb connect "$ip:$port"
    fi
  else
    echo "already connected"
  fi
  echo "remounting adb as root"
  adb root
  echo "starting ssh server"
  adb shell 'kill -s SIGTERM $(busybox pidof sshd)'
  gnome-terminal -e 'adb shell /data/ssh/sshd-start.sh'
  sleep 10
  fssh=$(mktemp -d)
  export fssh
  sshfs root@"$ip":/storage/emulated/0 "$fssh" -C -o big_writes
}

if [[ $method == ssh ]]; then sshs; else mtp; fi

a="${fssh:-${fmtp}}"
ad="$a/Download"
ap="$a/Pictures"
ao="$ad/overchan"
ak="$a/Kate"
dl="$HOME/Downloads"

echo "Mount path: $b"
echo "Internal space path: $a"
whattomove=( $(ls -b "$ad/"*.{webm,gif,jpg,pdf,jpeg,png} "$ad"/Dashchan/* "$a"/Telegram/{,*/}* "$ap"/Telegram/* "$ao"/*/*.{webm,gif,jpg,jpeg,png} "${ak}Photos"/* "${ak}Downloads"/*) )
rmv "$ap"/Screenshots/* "$HOME/sync/main/Screens"
rmv "${whattomove[@]}" "$dl"
if ls "$ao"/*/*-*/originals/* &>/dev/null; then
  echo "found files"
  rmv "$ao"/*/*-*/originals/* "$dl"
  rm -r "${ao:?}"/*
else
  echo "files not found"
  if ls "$ao"/* &>/dev/null; then rm -r "${ao:?}"/*; fi
fi
## rm -r $(ls -d $ao/*/*-*/)
fusermount -u "${b:-${fssh}}"
if [[ $method == ssh ]]; then
  adb shell 'kill -s SIGTERM $(busybox pidof sshd)'
  rmdir "$a"
fi

#adb shell "/system/bin/kill -s SIGTERM $(/system/bin/pidof sshd)"
#/system/xbin/busybox
