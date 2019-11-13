#!/bin/bash
for id in $(xinput|grep -E "Logitech USB Receiver.*pointer"|awk '{print $6}'|sed 's/id=//'); do xinput --set-prop "$id" "Device Accel Velocity Scaling" 1 && echo "Mouse acceleration for $id set to 1"; done && echo "mouse sensetivity set to 0" && xset m 0/0 0 && echo "xset sensetivity set to 0"

#xset mouse 2 0
