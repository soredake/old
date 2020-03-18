#!/bin/bash
# shellcheck disable=2162
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

RED="\e[1;31m"
GRAY="\033[0m"

red() {
  echo -e "${RED}$*" "${GRAY}"
}

die() {
  echo -e "${RED}$*" "${GRAY}"
  exit 1
}

network_setup() {
  printf 'nameserver 8.8.8.8' > /etc/resolv.conf
  printf 'Europe/Kiev' > /etc/timezone
  cp /etc/init.d/net.{lo,eth0}
  red "Starting network..."
  rc-config start net.eth0
  rc-config stop hwclock
  rc-config start swclock
}

swap_setup() {
  red "Creating swap"
  dd if=/dev/zero of=/swapfile bs=1M count=1024
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  printf "/swapfile none swap defaults 0 0" >> /etc/fstab
}

portage_git_init() {
  red "Switching portage tree to git in /usr/portage"
  pushd /usr/portage
  git init
  git remote add origin https://anongit.gentoo.org/git/repo/gentoo.git
  git fetch --depth=1
  git checkout -ft origin/master
  popd
}

main() {
# Link Portage stuff.
./setup-portage.sh

# Install portage packages.
./portage.sh

# Stow work.
../etc/install.sh
../home/install.sh
../root/install.sh
../service.conf/install.sh

# setup systemd .service symlinks
./systemd-links.sh

# Setup dotfiles.
../dotfiles.sh -f

# Setup linux.
./linux.sh

# Setup docker.
#./docker.sh

# native enable systemd services
#./systemd.sh
}

export -f main

read -p "Choose username? " NEWUSER;
BASE=$(basename "$(realpath "$SD"/..)")
dotpath="/home/$NEWUSER/git"
if grep --quiet "$NEWUSER" /etc/passwd; then
  red "User exists, starting stage2...."
  main
else
  red "User not exists, starting stage1...."
  eselect locale set en_US.utf8
  rm -r /etc/portage
  cp -r "$SD"/../etc/portage/portage /etc/portage
  rm /etc/portage/repos.conf/*.conf
  cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
  cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime
  busybox ntpd -q -p 0.gentoo.pool.ntp.org 1.gentoo.pool.ntp.org 2.gentoo.pool.ntp.org 3.gentoo.pool.ntp.org
  emerge --sync
  ln -sfv /usr/portage/profiles/default/linux/arm/13.0/armv7a/systemd /etc/portage/make.profile
  swap_setup
  emerge --rage-clean sys-fs/udev
  emerge --getbinpkg=y --usepkg=y dev-vcs/git || die "emerge git failed"
  emerge --getbinpkg=y --usepkg=y app-admin/stow app-admin/sudo app-shells/zsh net-misc/networkmanager sys-apps/rng-tools app-emulation/docker || die "emerge failed"
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/00wheel
  red "Creating data group..."
  groupadd -g 1500 data
  red "Creating user..."
  # UMASK=027 is not posible because of etc and root links
  useradd -K UMASK=022 -m -G users,data,docker,wheel -s /bin/zsh "$NEWUSER"
  red "Password for user"
  passwd "$NEWUSER" || die "setting user password failed"
  red "Password for root"
  passwd root || die "setting root password failed"
  red "Creating user dirs"
  sudo -u "$NEWUSER" -s mkdir -p cdata git mdata media .cache .config .local/share
  portage_git_init
  red "Owning this repository"
  chown -R "$NEWUSER:$NEWUSER" "$SD"/..
  rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h --remove-source-files "$SD"/../../"$BASE" "$dotpath" # or "$(realpath "$SD"/..)"
  sudo -u "$NEWUSER" -s "$dotpath"/"$BASE"/scripts/home.sh
fi
