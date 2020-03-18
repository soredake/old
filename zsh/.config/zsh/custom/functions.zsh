# shellcheck disable=2034,2148

# Create a new directory and enter it.
# In oh-my-zsh take function is identical to this
mkd() {
  mkdir -p "$@" && cd "$_" || exit 1;
}

# Convert currencies; cconv {amount} {from} {to}
cconv() {
  #| grep '&#8372;</strong>'
  result="$(curl -s "https://exchangerate.guru/$2/$3/$1/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')"
  echo "$1 $2 = $result $3"
}

# 5gb max, stores for 24 hours
cockfile() { curl --progress-bar -F file=@"$1" https://cockfile.com/api.php?d=upload-tool; }

j() {
case "$1" in
  d) cd "$HOME/main/Documents" ;;
  g) cd "$HOME/git" ;;
  m) cd "/media" ;;
  s) cd "$HOME/main" ;;
  t) cd /media/disk0/torrents ;;
  *) echo "No folder defined for this alias." ;;
esac
}

# 512mb max, stores for 30+ days
0x0() {
  if [[ "$1" =~ ^http?[s]://.*$ ]]; then local prefix="url="; else local prefix="file=@"; fi
  curl -F"${prefix}${1}" https://0x0.st
}

# rclone alias
# https://stackoverflow.com/questions/45601589/zsh-not-recognizing-alias-from-within-function
# https://stackoverflow.com/questions/25532050/newly-defined-alias-not-working-inside-a-function-zsh
# TODO remove when https://github.com/rclone/rclone/issues/2697 is done
alias -g uploadd="rclone sync --transfers 8 --delete-excluded --fast-list -P --delete-before"

# backup
backup() {
  # local
  rsync-synchronize "$HOME/main" /media/disk0/backup
  rsync-synchronize -L "$HOME/share" /media/disk0/backup
  rsync-synchronize "$HOME/main/Documents/NewDatabase.kdbx" "/media/disk2/Users/User/Desktop"
  rsync-synchronize "$HOME/main/Documents/NewDatabase.kdbx" "$HOME/share"
  # fix errors like `some-file.jpg: Duplicate object found in destination - ignoring` https://github.com/rclone/rclone/issues/2131#issuecomment-372459713
  rclone dedupe --dedupe-mode newest 50gbmega:/
  rclone dedupe --dedupe-mode newest 15gbmega:/
  # dropbox 2gb
  # TODO: https://plati.ru/search/DROPBOX
  echo "Uploading to Dropbox"
  uploadd "$HOME/main/Documents" dropbox:/Documents
  # google drive 15gb
  echo "Google Drive"
  uploadd "$HOME/main" gdrive:/
  # mega.nz 50gb
  echo "Uploading to MEGA 50gb"
  uploadd "$HOME/main" 50gbmega:/
  # mega.nz 15gb
  echo "Uploading to MEGA 15gb"
  uploadd "$HOME/main" 15gbmega:/
  # yandex.disk 10gb
  echo "Uploading to Yandex.Disk"
  uploadd "$HOME/main" yandex:/
}

# ukr nalogi
# https://duckduckgo.com/?q=(400+-+165)+*+35%25&ia=calculator
# https://rozetka.com.ua/news-articles-promotions/promotions/261738.html
ukr_nalogi() {
  if [[ "$1" -ge "151" ]]; then
    poshlina=$(bc -l <<< "($1 - 150) * 0.10")
    echo Tax is: $(bc -l <<< "($1 - 100 + $poshlina) * 0.20 + $poshlina") EUR
  else
    echo Tax is: $(bc -l <<< "($1 - 100) * 0.20") EUR
  fi
}

# https://www.checkyourmath.com/convert/length/inches_cm.php
cmtoinch() { echo $(bc -l <<< "$1 / 2.54"); }
inchtocm() { echo $(bc -l <<< "$1 * 2.54"); }

# update everything
update() {
  yay -Syuu --combinedupgrade --answerclean n --answerdiff n --answerupgrade y --noconfirm
  sudo etc-update
  flatpak --user update --noninteractive
  snap refresh
  fwupdmgr refresh
  fwupdmgr update
  zinit self-update
  zinit update
  tldr --update
}

speak() {
  trans -speak -s ru "$1" -download-audio-as "$XDG_RUNTIME_DIR/trans-speak.ts"
  ffmpeg -y -i "$XDG_RUNTIME_DIR/trans-speak.ts" "$XDG_RUNTIME_DIR/trans-speak.ogg"
  echo "$XDG_RUNTIME_DIR/trans-speak.ogg" | clipcopy
}