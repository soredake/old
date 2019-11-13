#!/bin/bash
# https://stackoverflow.com/questions/16703647/why-curl-return-and-error-23-failed-writing-body
# @TODO: git ls-remote --tags https://github.com/EFForg/https-everywhere | grep -Eo '[0-9][0-9][0-9][0-9]\.[0-9][0-9]?\.[0-9][0-9]?' | sort -g
# curl "https://www.eff.org/files/Changelog.txt" | tac | tac | head -n1 -
set -e
cd /tmp
rm -rf https-everywhere*
version="$(curl -sN "https://www.eff.org/files/Changelog.txt" | head -n1)"
# not working as there is no releases from api https://github.com/lutris/lutris/issues/974#issue-343310698
#version="$(curl -s https://api.github.com/repos/EFForg/https-everywhere/releases  | jq '[.[] | .name] | join(", ")')"
git clone https://github.com/EFForg/https-everywhere --depth=1 -b "${version}"
cd https-everywhere
pushd src/chrome/content/rules
cp "$HOME/git/misc/firefox/herules/"*.xml "$PWD"
pushd
sed -i "s|bash utils/validate.sh||g" make.sh
./make.sh
cp pkg/*eff.xpi /tmp
