#!/bin/bash
#echo -e "fastestmirror=True\nmax_parallel_downloads=5\ndeltarpm=true"|sudo tee -a /etc/dnf/dnf.conf
#sudo dnf copr enable dawid/better_fonts -y
sudo dnf copr enable zawertun/hack-fonts -y # https://bugzilla.redhat.com/show_bug.cgi?id=1258542
# Install my packages
# TODO: icoutils(needed for exe preview) as dep for wine https://src.fedoraproject.org/rpms/wine/blob/rawhide/f/wine.spec or dolphin
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm https://mirrors.rpmfusion.org/{free/fedora/rpmfusion-,nonfree/fedora/rpmfusion-non}free-release-$(rpm -E %fedora).noarch.rpm
packages=(https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.3.10.noarch.rpm https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm python3-dnf-plugin-system-upgrade bottles android-tools aria2 bleachbit chntpw fish gimp lm_sensors hack-fonts lutris mpv plasma-discover-snap qdirstat rclone-browser retroarch seahorse steam stow vitetris wine trash-cli safeeyes)
#packages+=(libappindicator-gtk3 python3-psutil cairo-devel python3-devel gobject-introspection-devel cairo-gobject-devel) # safeeyes https://github.com/slgobinath/SafeEyes/issues/432
sudo dnf install -y ${packages[@]}
# https://rpmfusion.org/Configuration
# https://fedoramagazine.org/things-to-do-after-installing-fedora-34-workstation/
# https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/
sudo dnf groupupdate core sound-and-video multimedia

# https://snapcraft.io/docs/installing-snap-on-fedora
sudo systemctl start snapd
sudo ln -s /var/lib/snapd/snap /snap

sudo snap install code --classic
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher com.mojang.Minecraft net.rpcs3.RPCS3 org.telegram.desktop org.freefilesync.FreeFileSync
sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
sudo flatpak override org.jdownloader.JDownloader --filesystem=host # https://github.com/flathub/org.jdownloader.JDownloader/pull/19
pip install -U git+https://github.com/simons-public/protonfixes protontricks internetarchive #safeeyes
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
#aria2c -c -d "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
#sudo gtk-update-icon-cache /usr/share/icons/hicolor # safeeyes

# setup dofiles
etc_cp/install.sh
home/install.sh

# general settings
sudo ln -sfv "$HOME/.config/fontconfig/fonts.conf" /etc/fonts/local.conf # https://bugs.launchpad.net/snapd/+bug/1916867
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
#sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop" # https://bugs.kde.org/show_bug.cgi?id=413053
