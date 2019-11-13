#!/system/xbin/bash

if [[ -d /data/data/org.mozilla.fennec_fdroid/files/mozilla ]]; then
  cd /data/data/org.mozilla.fennec_fdroid/files/mozilla || exit 1
  cd "$(sed -n -e 's/^.*Path=//p' profiles.ini)" || exit 1
  EXISTS="1"
else
  cd /data/data/org.mozilla.fennec_fdroid/files || exit 1
  ouser=$(stat -c "%U" ../fonts)
  echo "User is: $ouser"
  mkdir -p mozilla/fennecmobile.default
  touch mozilla/profiles.ini mozilla/fennecmobile.default/user.js
  chown -R "$ouser":"$ouser" mozilla
  chmod -R 700 mozilla
  cd mozilla || exit 1
  tail profiles.ini >/dev/null <<END
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=fennecmobile.default
Default=1
END
  chattr +i profiles.ini
  cd fennecmobile.default || exit 1
fi
curl -O https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js
if [[ "$EXISTS" == "1" ]]; then
  ouser=$(stat -c "%U" prefs.js)
  echo "User is: $ouser"
  chmod 700 user.js
fi

# android version is need this https://github.com/pyllyukko/user.js/pull/136#issuecomment-206812337
sed -i '/layers.acceleration.disabled/d' user.js
chown "$ouser":"$ouser" user.js

unset EXISTS
