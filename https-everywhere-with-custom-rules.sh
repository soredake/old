#!/bin/bash
set -e
cd /tmp
git clone https://github.com/EFForg/https-everywhere
cd https-everywhere
git checkout "$(git describe --tags "$(git rev-list --tags --max-count=1)")"
pushd src/chrome/content/rules
cp "$HOME/git/misc/firefox/herules/"*.xml "$PWD"
pushd
sed -i "s|bash utils/validate.sh||g" make.sh
./make.sh
cp pkg/*eff.xpi /tmp
