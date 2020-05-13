#!/bin/bash
# https://web.archive.org/web/20181102011252/http://www.michaelabrahamsen.com/posts/arch-linux-iso-zfs/
if [[ "${2}" == "docker" ]]; then
  docker pull base/devel
  docker run --privileged -it -v "${1}"/archiso:/archiso base/devel
fi

[[ ! -d "${1}/archiso" ]] && mkdir -p "${1}/archiso"
cd "${1}/archiso" || exit 1
cp -rf /usr/share/archiso/configs/releng/* .

sed -i "s|systemctl set-default multi-user.target|systemctl set-default graphical.target|g" airootfs/root/customize_airootfs.sh

ln -sfv /usr/lib/systemd/system/sddm.service airootfs/etc/systemd/system/display-manager.service

mkdir -p airootfs/etc/sddm.conf.d
sed -e "s/MinimumUid=1000/MinimumUid=0/g" -e "s/MaximumUid=60000/MaximumUid=0/g" /usr/lib/sddm/sddm.conf.d/default.conf > airootfs/etc/sddm.conf.d/default.conf

ZFS="false"
KDE="true"

# https://wiki.archlinux.org/index.php/Frequently_asked_questions#When_will_the_new_release_be_made_available?
# https://git.archlinux.org/archiso.git/tree/configs/releng/packages.x86_64
tee -a packages.x86_64 >/dev/null <<END
firefox
gparted
htop
keepassxc
lsof
p7zip
pulseaudio-alsa
sddm
ttf-dejavu
ttf-hack
unrar
xfce4
xorg-server
zip
END

if [[ "${KDE}" == "true" ]]; then
tee -a packages.x86_64 >/dev/null <<END
plasma-meta
kdebase-meta
gwenview
okular
ark
END
fi

if [[ "${ZFS}" == "true" ]]; then
tee -a pacman.conf >/dev/null <<END
[archzfs]
SigLevel = Optional TrustAll
Server = https://archzfs.com/\$repo/x86_64
[archzfs-kernels]
Server = http://end.re/\$repo/
END
tee -a packages.x86_64 >/dev/null <<END
archzfs
END
fi

#sudo 
./build.sh -v -o "${1}" -N archiso -V none