#!/system/bin/env bash

mkdir test
cd test
git clone https://github.com/vicgeralds/vitetris
cd vitetris
./configure
make
cp tetris ~/bin
rm -rf ~/test
