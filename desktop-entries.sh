#!/bin/bash
ush='/usr/share/applications'
cd "$XDG_DATA_HOME/applications" || exit 1
#sed -e '15,24d' -e '11,13d' -e '4,9d' -e "s/pseudo-gui/pseudo-gui --profile=image/g" -e "s/Play movies and songs/View images/g" -e "s/Media Player/Image Viewer/g" -e "s/Multimedia player/Image Viewer/g" $ush/mpv.desktop >mvi.desktop
#sed -e '/^Name=/s/=.*/=Htop (root)/' -e '/^Exec=/s/=.*/="sudo htop"/' $ush/htop.desktop >htop-root.desktop

# discord firejail
#sed -e 's/^Name=.*/Name=Discord (firejail)/g' -e 's|^Exec=.*|Exec=discord-run -- %u|g' /usr/share/applications/discord.desktop > discord-firejail.desktop

# update desktop db
# https://wiki.archlinux.org/index.php/Desktop_entries#Update_database_of_desktop_entries
#update-desktop-database -v "$XDG_DATA_HOME/applications"