#!/bin/bash

SD="$(cd "$(dirname "$0")" >/dev/null || exit 1; pwd)";
cd "$SD" || exit 1

default() {
  cd "$HOME/.mozilla/torbrowser" || exit 1
  grep -B 1 "Default=1" profiles.ini | grep Path= | sed 's/Path=//g' | xargs realpath
}

FXPROFILE="${2:-$(default)}";
FXPROFILET="$(basename "$FXPROFILE")";
BACKUPF="$SD/backup-${FXPROFILET}"
[[ ! -d "$BACKUPF" ]] && install -d -m 700 "$BACKUPF"

rsyncp() {
  rsync --relative --archive --acls --xattrs --compress --progress --verbose -h "$@"
}

pb() {
  [[ "$3" == "d" ]] && local dpref="extensions."
  grep -r "user_pref(\"${dpref}$1" prefs.js > "$BACKUPF/$2.js"
}

backup() {
  cd "$FXPROFILE" || exit 1
  if [[ "$FXPROFILET" == tor-main ]]; then
    rsyncp browser-extension-data/{uBlock0@raymondhill.net,firefox-extension@steamdb.info,@cloudhole,\{73a6fe31-595d-460b-a920-fcc0f8843232\}}/storage.js search.json.mozlz4 permissions.sqlite gm_scripts "$BACKUPF"
    pb '{1280606b-2510-4fe0-97ef-9b5a22eafe30}.' sessionmanager d
    pb 'browser.uiCustomization.state' uicustomization
    #pb 'multipletab.' multipletab d
    pb 'openwith.' openwith d
    #pb 'tabmix.' tabmix d
    #pb 'treestyletab.' treestyletab d
  else
    rsyncp browser-extension-data/{firefox-extension@steamdb.info,@cloudhole,\{73a6fe31-595d-460b-a920-fcc0f8843232\}}/storage.js search.json.mozlz4 gm_scripts permissions.sqlite
  fi
}

restore() {
  if [[ "$FXPROFILET" == tor-main ]]; then
    cat ./user.js ./tor-main.js > "$FXPROFILE/user.js"
  else
    cp ./user.js "$FXPROFILE"
  fi
  cd "$BACKUPF" || exit
  if [[ "$FXPROFILET" == tor-main ]]; then
    rsyncp browser-extension-data/{uBlock0@raymondhill.net,firefox-extension@steamdb.info,@cloudhole,\{73a6fe31-595d-460b-a920-fcc0f8843232\}}/storage.js search.json.mozlz4 gm_scripts "$FXPROFILE"
  else
    rsyncp browser-extension-data/{firefox-extension@steamdb.info,@cloudhole,\{73a6fe31-595d-460b-a920-fcc0f8843232\}}/storage.js search.json.mozlz4 gm_scripts "$FXPROFILE"
  fi
}

case "$1" in
    backup) backup ;;
    restore) restore ;;
    *) echo $"Usage: $0 {backup|restore} \$profile"
       exit 1
esac
