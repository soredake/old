#!/bin/bash

# https://superuser.com/questions/775785/how-to-disable-a-keyboard-key-in-linux-ubuntu
# up key is broken, disable it
xmodmap -e 'keycode 111=NoSymbol'

# https://askubuntu.com/questions/296155/how-can-i-remap-keyboard-keys
# remap PB key as UP
xmodmap -e "keycode 127=Up"