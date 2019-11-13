#!/system/xbin/bash

cd /data/data/org.mozilla.fennec_fdroid/files/mozilla || exit 1
cd "$(sed -n -e 's/^.*Path=//p' profiles.ini)" || exit 1
curl -O https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js
ouser=$(stat -c "%U" prefs.js)
echo "User is: $ouser"

# android version is need this https://github.com/pyllyukko/user.js/pull/136#issuecomment-206812337
sed -i '/layers.acceleration.disabled/d' user.js
chown "$ouser":"$ouser" user.js
chmod 700 user.js
