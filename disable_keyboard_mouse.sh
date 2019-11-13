#!/bin/bash
# https://unix.stackexchange.com/questions/17170/disable-keyboard-mouse-input-on-unix-under-x

time="${1:-70}"

KEYBOARD=$(xinput list --id-only "keyboard:HID 04f3:0103")
for id in $(xinput|grep -E "A4TECH.*pointer"|awk '{print $6}'|grep "[0-910-19]" -o); do
  xinput --set-prop "$id" "Device Enabled" 0 && echo "Mouse $id disabled"
done
xinput --set-prop "$KEYBOARD" "Device Enabled" 0 && echo "Keyboard №$KEYBOARD disabled"
echo -e "Disabling keyboard and mouse for \e[1;31m$time \033[0mseconds" && sleep "$time"
for id in $(xinput|grep -E "A4TECH.*pointer"|awk '{print $6}'|grep "[0-910-19]" -o); do
  xinput --set-prop "$id" "Device Enabled" 1 && echo "Mouse №$id enabled"
done
xinput --set-prop "$KEYBOARD" "Device Enabled" 1 && echo "Keyboard №$KEYBOARD enabled"

mouse-acceleration-disable_logitech.sh
