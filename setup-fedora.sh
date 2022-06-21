#!/bin/bash
curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo bash -
sudo dnf copr enable batmanfeynman/syncplay -y
sudo dnf copr enable capucho/steamtinkerlaunch -y
sudo dnf copr enable zawertun/hack-fonts -y # https://bugzilla.redhat.com/show_bug.cgi?id=1258542
# TODO: icoutils https://src.fedoraproject.org/rpms/icoutils/pull-request/1, python3-dnf-plugin-system-upgrade https://pagure.io/fedora-kde/SIG/issue/3, btrfsmaintenance https://pagure.io/fedora-btrfs/project/issue/16
# lutris/bottles/retroarch/steam flatpak blockers: https://github.com/flathub/net.lutris.Lutris/issues/198 https://github.com/bottlesdevs/Bottles/issues/1571 https://github.com/flathub/com.valvesoftware.Steam/issues/770 https://github.com/flatpak/flatpak/pull/4083 https://github.com/flathub/org.libretro.RetroArch/issues/194 https://github.com/flatpak/flatpak/issues/4405 https://github.com/systemd/systemd/issues/22681 https://github.com/PaulCombal/SamRewritten/issues/128
#sudo dnf remove -y 
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-36-1.noarch.rpm https://mirrors.rpmfusion.org/{free/fedora/rpmfusion-,nonfree/fedora/rpmfusion-non}free-release-$(rpm -E %fedora).noarch.rpm
packages=(https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.4.3.noarch.rpm icoutils nodejs btrfsmaintenance python3-dnf-plugin-system-upgrade bottles android-tools chntpw fish lm_sensors hack-fonts lutris mpv plasma-discover-snap qdirstat rclone retroarch steam stow vitetris wine safeeyes syncplay code protontricks tor steamtinkerlaunch mangohud vkbasalt gamescope)
sudo dnf install -y ${packages[@]}
sudo dnf group install core sound-and-video multimedia # https://rpmfusion.org/Configuration
flatpak install -y flathub org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher net.rpcs3.RPCS3 net.davidotek.pupgui2 org.gnome.seahorse.Application com.github.maoschanz.drawing org.gimp.GIMP org.keepassxc.KeePassXC org.qbittorrent.qBittorrent org.zealdocs.Zeal com.parsecgaming.parsec org.ppsspp.PPSSPP com.steamgriddb.steam-rom-manager
pip install --user internetarchive
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
wget -P "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
# https://yarnpkg.com/getting-started/install https://nodejs.org/dist/latest/docs/api/corepack.html
mkdir ~/.local/bin; corepack enable --install-directory ~/.local/bin; yarn set version stable
# https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md
mkdir ~/Applications
cd ~/Applications
wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)
chmod +x appimaged-*.AppImage
./appimaged-*.AppImage
# 64gram
wget -c https://github.com/$(wget -q https://github.com/TDesktop-x64/tdesktop/releases -O - | grep "64Gram.*_linux.zip" | head -n 1 | cut -d '"' -f 2)
unzip 64* -d 64gram
./64gram/Telegram
# TODO: itch steascree emusak-ui

etc_cp/install.sh; home/install.sh

sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
sudo ln -sfv "$HOME/.config/fontconfig/fonts.conf" /etc/fonts/local.conf # https://bugs.launchpad.net/snapd/+bug/1916867 https://bugzilla.mozilla.org/show_bug.cgi?id=1760996
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
sudo sed -i -e "/^BTRFS_SCRUB_PERIOD=/s/=.*/=\"none\"/" -e "/^BTRFS_DEFRAG_PERIOD=/s/=.*/=\"monthly\"/" -e "/^BTRFS_DEFRAG_PATHS=/s/=.*/=\"\/\"/" -e "/^BTRFS_BALANCE_PERIOD=/s/=.*/=\"monthly\"/" /etc/sysconfig/btrfsmaintenance # https://stackoverflow.com/a/19567449/4207635
sudo systemctl start btrfsmaintenance-refresh
