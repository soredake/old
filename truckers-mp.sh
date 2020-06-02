#!/bin/bash

listurl=https://update.ets2mp.com
dlurl=https://download.ets2mp.com/files
base="$PWD"
dldir="$base/prefix/drive_c/truckersmp"

mkdir -p "$dldir"
wget --no-check-certificate "$listurl/files.json" -O "./files.json"

cat "./files.json" | awk 'BEGIN{i=0}/":"/{printf $0;i=1;next}{if (i) {printf "\n"; i=0}}' | awk -F '"' '{printf "%s %s\n",$8,$4}' > "./.checksums"
files=( $(cat "./.checksums" | md5sum -c --quiet - 2> /dev/null | awk -F ':' '{print $1}') )

for f in ${files[@]}; do
    echo "f = $f"
    mkdir -p "$dldir/$(dirname $f)"
    wget --no-check-certificate $dlurl/$f -O "$dldir/$f"
done

rm -f ".checksums" "files.json"
