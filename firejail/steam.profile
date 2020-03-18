# Steam profile
# protect me from https://github.com/ValveSoftware/steam-for-linux/issues/3671
blacklist ~/sync
ignore shell
# for dualshock 4
ignore private-dev
include /etc/firejail/steam.profile
join-or-start steam
