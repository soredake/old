#!/bin/bash
# https://miui.blog/redmi-note-5/whyred-enable-camera2-api/
# https://forum.xda-developers.com/mi-a2-lite/how-to/guide-how-to-enable-camera2-api-t3851414
adb shell <<END
#su -c 'setprop persist.camera.HAL3.enabled 1; setprop persist.camera.eis.enabled 1'
su -c 'mount -o remount,rw /system'
su -c 'echo "persist.camera.HAL3.enabled=1\npersist.camera.eis.enabled=1" >>/system/build.prop'
su -c 'mount -o remount,ro /system'
END
adb reboot
