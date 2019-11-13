#!/bin/bash
hf="$HOME/git/hosts"
SD="$(cd "$hf" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1
addsource() {
  src="$SD/data/$1"
  [[ ! -d "$src" ]] && mkdir "$src" || return 1
  tee "$src/update.json" >/dev/null <<END
{
    "name": "$1",
    "description": "",
    "homeurl": "",
    "frequency": "",
    "issues": "",
    "url": "$2"
}
END
}

blacklist() { tee -a "$SD/blacklist" >/dev/null <<< "0.0.0.0 $1"; }

git reset --hard
git pull --depth=1
for _b in r3.mail.ru top-fwz1.mail.ru; do blacklist "$_b"; done
gh='https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/win'
for v in 7 81 10; do
  for w in extra spy update; do addsource "${v}-${w}" "${gh}${v}/${w}.txt"; done
done
addsource malwaredomains https://mirror1.malwaredomains.com/files/justdomains
addsource zeustracker https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
addsource disconnect1 https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
addsource disconnect2 https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
addsource dns-add-block https://raw.githubusercontent.com/mat1th/Dns-add-block/master/hosts

addsource hosts-file https://hosts-file.net/ad_servers.txt

python updateHostsFile.py -e gambling fakenews -a -r
