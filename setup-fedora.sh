#!/bin/bash
# curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo bash -
sudo dnf copr enable batmanfeynman/syncplay -y
sudo dnf copr enable rivenirvana/steamtinkerlaunch -y
sudo dnf copr enable elxreno/bees -y
sudo dnf copr enable zawertun/hack-fonts -y # https://bugzilla.redhat.com/show_bug.cgi?id=1258542
# gamepad udev rules https://github.com/systemd/systemd/issues/22681, python3-dnf-plugin-system-upgrade https://pagure.io/fedora-kde/SIG/issue/247 https://pagure.io/fedora-kde/SIG/issue/3, btrfsmaintenance https://pagure.io/fedora-btrfs/project/issue/16
# lutris/steam/bottles flatpak blockers: https://github.com/flathub/net.lutris.Lutris/issues/198 https://github.com/flathub/com.valvesoftware.Steam/issues/770 https://github.com/PaulCombal/SamRewritten/issues/128 https://github.com/flathub/net.lutris.Lutris/issues/200 https://github.com/bottlesdevs/Bottles/issues/1366 https://github.com/flathub/com.valvesoftware.Steam/issues/85
sudo dnf remove -y akregator grantlee-editor dragon qt5-qdbusviewer kmahjongg kmines kpat konversation krdc krfb kamoso kaddressbook korganizer mediawriter kgpg kwrite kf5-akonadi-server # qt-remote-viewer TODO: https://russianfedora.github.io/FAQ/tips-and-tricks.html#kde
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-36-1.noarch.rpm https://mirrors.rpmfusion.org/{free/fedora/rpmfusion-,nonfree/fedora/rpmfusion-non}free-release-$(rpm -E %fedora).noarch.rpm
packages=(https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.4.3.noarch.rpm nodejs bottles bees btrfs-assistant chntpw code fish gamescope hack-fonts lm_sensors lutris mangohud mpv protontricks python3-dnf-plugin-system-upgrade qdirstat rclone safeeyes steam steamtinkerlaunch stow syncplay tor virt-manager vitetris vkbasalt wine) # ncdu rust-dua-cli
sudo dnf install -y ${packages[@]}
# sudo dnf module install -y nodejs:18/common
sudo dnf group install -y core sound-and-video multimedia # https://rpmfusion.org/Configuration
flatpak install -y flathub com.discordapp.Discord com.github.maoschanz.drawing com.github.micahflee.torbrowser-launcher com.github.mtkennerly.ludusavi com.github.ztefn.haguichi com.parsecgaming.parsec com.spotify.Client com.steamgriddb.steam-rom-manager com.valvesoftware.Steam.CompatibilityTool.Proton-GE com.viber.Viber io.github.philipk.boilr net.davidotek.pupgui2 net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.citra_emu.citra org.gimp.GIMP org.gnome.seahorse.Application org.jdownloader.JDownloader org.keepassxc.KeePassXC org.libretro.RetroArch org.ppsspp.PPSSPP org.ppsspp.PPSSPP org.qbittorrent.qBittorrent org.yuzu_emu.yuzu space.crankshaft.Crankshaft
pip install --user internetarchive
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
#wget -P "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
# https://yarnpkg.com/getting-started/install https://nodejs.org/dist/latest/docs/api/corepack.html
# TODO: create .local/bin by default in fedora?
mkdir ~/.local/bin
corepack enable --install-directory ~/.local/bin
yarn set version stable
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

etc_cp/install.sh
home/install.sh

# https://github.com/flathub/com.valvesoftware.Steam/issues/85#issuecomment-650597824
flatpak --user override --filesystem=xdg-data/icons --filesystem=xdg-data/applications --filesystem=xdg-desktop com.valvesoftware.Steam
# and for bottles
flatpak --user override --filesystem=xdg-data/icons --filesystem=xdg-data/applications --filesystem=xdg-desktop com.usebottles.bottles
# https://github.com/flatpak/flatpak/issues/3947
flatpak override --user --filesystem=xdg-config/steamtinkerlaunch:ro --filesystem=xdg-config/MangoHud:ro --filesystem=xdg-config/vkBasalt:ro --filesystem=xdg-config/fontconfig:ro
# https://github.com/flatpak/flatpak/issues/1563
mkdir "$HOME/.config/fontconfig/conf.d"
cp --reflink=auto /etc/fonts/conf.d/*{noto,hack}* "$HOME/.config/fontconfig/conf.d"
#flatpak override --user --env=_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
# https://bugs.launchpad.net/snapd/+bug/1916867 https://bugzilla.mozilla.org/show_bug.cgi?id=1760996
sudo ln -sfv "$HOME/.config/fontconfig/fonts.conf" /etc/fonts/local.conf
sudo tee -a /usr/share/sddm/scripts/Xsetup <<<"xmodmap $HOME/git/dotfiles_home/home/xmodmap/.Xmodmap"
sudo sed -i -e "/^BTRFS_SCRUB_PERIOD=/s/=.*/=\"none\"/" -e "/^BTRFS_BALANCE_PERIOD=/s/=.*/=\"monthly\"/" /etc/sysconfig/btrfsmaintenance # https://stackoverflow.com/a/19567449/4207635
sudo systemctl start btrfsmaintenance-refresh
#sudo grubby --update-kernel=ALL --args="retbleed=off" # https://www.reddit.com/r/Amd/comments/vyaqwf/comment/ig1x0kq/
# bees setup
export UUID="$(blkid -o value -s UUID /dev/nvme0n1p2)"
sudo cp /etc/bees/beesd.conf.sample /etc/bees/$UUID.conf
sudo sed -i "s|xxxxxxxx-xx.*|$UUID|" /etc/bees/$UUID.conf
sudo systemctl enable --now beesd@$UUID.service
