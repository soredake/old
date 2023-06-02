# https://en.opensuse.org/SDB:Installing_codecs_from_Packman_repositories
sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/' packman
# https://en.opensuse.org/SDB:KDE_repositories
sudo zypper ar -fp 75 'https://download.opensuse.org/repositories/KDE:/Qt5/openSUSE_Leap_$releasever' KDE-Qt5
sudo zypper ar -fp 75 'https://download.opensuse.org/repositories/KDE:/Frameworks5/openSUSE_Leap_$releasever' KDE-Frameworks
sudo zypper ar -fp 75 'https://download.opensuse.org/repositories/KDE:/Applications/KDE_Frameworks5_openSUSE_Leap_$releasever' KDE-Applications
sudo zypper ar -fp 75 'https://download.opensuse.org/repositories/KDE:/Extra/KDE_Applications_openSUSE_Leap_$releasever' KDE-Extra
# https://github.com/openSUSE/zypper/issues/420
sudo zypper --non-interactive dup --download-only
while [ $? -ne 0 ]; do
    echo "Download failed; retrying..."
    sleep 1
    sudo zypper --non-interactive dup --download-only
done
sudo zypper --gpg-auto-import-keys -v dup -y --allow-vendor-change
sudo zypper --gpg-auto-import-keys dup -y --from packman --allow-vendor-change
# sudo zypper install -y opi
# opi codecs
# https://opensuse.github.io/openSUSE-docs-revamped-temp/codecs/
sudo zypper install -y --from packman ffmpeg pipewire-aptx gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs zram-generator earlyoom
sudo wget -O /usr/lib/systemd/zram-generator.conf https://src.fedoraproject.org/rpms/rust-zram-generator/raw/rawhide/f/zram-generator.conf
echo -e "\ncompression-algorithm=zstd" | sudo tee -a /usr/lib/systemd/zram-generator.conf
sudo systemctl disable --now btrfs-trim.timer btrfs-scrub.timer
sudo systemctl enable --now earlyoom
sudo sed -e '/swap/ s/^#*/#/' -i /etc/fstab # https://stackoverflow.com/questions/17998763/sed-commenting-a-line-matching-a-specific-string-and-that-is-not-already-comme
sudo sed -e '/ \/ / s/defaults/autodefrag,compress=zstd,defaults/' -e '/btrfs/ s/subvol/autodefrag,compress=zstd,subvol/' -e '/BBB/ s/^#*/#/' -i /etc/fstab
# sudo tee /etc/modules-load.d/zstd.conf
