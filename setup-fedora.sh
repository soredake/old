#!/bin/bash
sudo dnf copr enable dawid/better_fonts -y
echo -e "fastestmirror=True\nmax_parallel_downloads=10"|sudo tee -a /etc/dnf/dnf.conf
# Install my packages
# https://pagure.io/fedora-kde/SIG/issue/52
# preinstall plasma-disks
# preinstall pulseaudio-module-gsettings https://pagure.io/fedora-kde/SIG
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
packages=(fontconfig-font-replacements fontconfig-enhanced-defaults https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.3.9.noarch.rpm dnf-plugin-system-upgrade android-tools aria2 bleachbit chntpw dolphin-plugins filelight fish gamemode gimp lm_sensors lutris mpv plasma-discover-snap qdirstat rclone-browser retroarch seahorse steam stow vitetris wine-devel simplescreenrecorder git icoutils)
packages+=(libappindicator-gtk3 python3-psutil cairo-devel python3-devel gobject-introspection-devel cairo-gobject-devel)
sudo dnf install -y ${packages[@]}
sudo dnf groupupdate -y core sound-and-video
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# https://snapcraft.io/docs/installing-snap-on-fedora
sudo systemctl enable snapd
sudo ln -s /var/lib/snapd/snap /snap

sudo snap install code --classic
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher com.mojang.Minecraft net.rpcs3.RPCS3 org.telegram.desktop org.freefilesync.FreeFileSync org.qbittorrent.qBittorrent org.keepassxc.KeePassXC
sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
sudo flatpak override org.telegram.desktop --filesystem=host # https://github.com/flathub/org.telegram.desktop/issues/23
sudo flatpak override org.jdownloader.JDownloader --filesystem=host
pip install -U git+https://github.com/simons-public/protonfixes protontricks internetarchive safeeyes
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
aria2c -c -d "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
sudo gtk-update-icon-cache /usr/share/icons/hicolor # safeeyes

# setup dofiles
etc_cp/install.sh
home/install.sh

# general settings
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop" # https://bugs.kde.org/show_bug.cgi?id=413053
