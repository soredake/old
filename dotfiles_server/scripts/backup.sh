#!/usr/bin/bash
# https://github.com/rr-/dotfiles/blob/master/bin/lan/backup-mysql

if [[ -z "$1" ]]; then
    echo 'No database specified' 1>&2
    exit 1
else
    dbname="$1"
fi

if [[ -z "$2" ]]; then
    echo 'No password specified' 1>&2
    exit 1
else
    password="$2"
fi

if ! command -v pgdump &>/dev/null; then
    echo 1>&2 'pgdump not found. Aborting.'
    exit 1
fi

day_of_week=$(date +'%A'|tr '[[:upper:]]' '[[:lower:]]')
path=~/.backup/sql/"$dbname"/"$day_of_week".tar
mkdir -p "$(dirname "$path")"

pg_dump -F tar -U docker "$dbname" >"$path"
