#!/bin/bash
sleep 10
# https://superuser.com/questions/775785/how-to-disable-a-keyboard-key-in-linux-ubuntu
# esc key is broken, disable it
xmodmap -e 'keycode 9=NoSymbol'

# https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys
# remap PB key as esc
xmodmap -e "keycode 127=Escape"
