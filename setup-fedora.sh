#!/bin/bash
#echo -e "fastestmirror=True"|sudo tee -a /etc/dnf/dnf.conf
#sudo dnf copr enable dawid/better_fonts -y
curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo bash -
sudo dnf copr enable zawertun/hack-fonts -y # https://bugzilla.redhat.com/show_bug.cgi?id=1258542
# Install my packages
# TODO: icoutils https://src.fedoraproject.org/rpms/icoutils/pull-request/1, python3-dnf-plugin-system-upgrade https://pagure.io/fedora-kde/SIG/issue/3, btrfsmaintenance https://pagure.io/fedora-btrfs/project/issue/16
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-36-1.noarch.rpm https://mirrors.rpmfusion.org/{free/fedora/rpmfusion-,nonfree/fedora/rpmfusion-non}free-release-$(rpm -E %fedora).noarch.rpm
packages=(https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.3.10.noarch.rpm icoutils nodejs btrfsmaintenance python3-dnf-plugin-system-upgrade bottles android-tools bleachbit chntpw fish gimp lm_sensors hack-fonts lutris mpv plasma-discover-snap qdirstat rclone retroarch seahorse steam stow vitetris wine trash-cli safeeyes)
sudo dnf install -y ${packages[@]}
# https://rpmfusion.org/Configuration
# https://fedoramagazine.org/things-to-do-after-installing-fedora-34-workstation/
# https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/
sudo dnf groupupdate -y core sound-and-video multimedia

# https://snapcraft.io/docs/installing-snap-on-fedora
sudo systemctl start snapd; sudo ln -s /var/lib/snapd/snap /snap

sudo snap install code --classic # https://github.com/microsoft/vscode/issues/141788 https://pagure.io/fedora-workstation/issue/283 https://packages.microsoft.com/yumrepos/vscode https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher net.rpcs3.RPCS3
sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
sudo flatpak override org.jdownloader.JDownloader --filesystem=host # https://github.com/flathub/org.jdownloader.JDownloader/pull/19 or https://github.com/pkg-src/jdownloader2.snap
pip install --user git+https://github.com/simons-public/protonfixes protontricks internetarchive
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
wget -P "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
# https://yarnpkg.com/getting-started/install https://nodejs.org/dist/latest/docs/api/corepack.html
mkdir ~/.local/bin; corepack enable --install-directory ~/.local/bin; yarn set version stable

# setup dofiles
etc_cp/install.sh; home/install.sh

# general settings
sudo ln -sfv "$HOME/.config/fontconfig/fonts.conf" /etc/fonts/local.conf # https://bugs.launchpad.net/snapd/+bug/1916867 https://bugzilla.mozilla.org/show_bug.cgi?id=1760996
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
#sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop" # https://bugs.kde.org/show_bug.cgi?id=413053
sudo sed -i -e "/^BTRFS_SCRUB_PERIOD=/s/=.*/=\"none\"/" -e "/^BTRFS_DEFRAG_PERIOD=/s/=.*/=\"monthly\"/" -e "/^BTRFS_DEFRAG_PATHS=/s/=.*/=\"\/\"/" -e "/^BTRFS_BALANCE_PERIOD=/s/=.*/=\"monthly\"/" /etc/sysconfig/btrfsmaintenance # https://stackoverflow.com/a/19567449/4207635
sudo systemctl start btrfsmaintenance-refresh

# https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md
mkdir ~/Applications
cd ~/Applications
wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)
chmod +x appimaged-*.AppImage
# Launch
./appimaged-*.AppImage
# syncplay
wget -c https://github.com/$(wget -q https://github.com/Syncplay/syncplay/releases -O - | grep "Syncplay.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)
# 64gram
wget -c https://github.com/$(wget -q https://github.com/TDesktop-x64/tdesktop/releases -O - | grep "64Gram.*_linux.zip" | head -n 1 | cut -d '"' -f 2)
unzip 64* -d 64gram
./64gram/Telegram
