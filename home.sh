#!/bin/bash
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

# https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation
# https://wiki.archlinux.org/index.php/Swap#Manually
resume_swap_file_setup() {
  red "Creating swapfile for hibernation"
  fallocate -l 16G /media/disk1/swapfile
  chmod 600 /media/disk1/swapfile
  mkswap /media/disk1/swapfile
  #printf "/media/disk1/swapfile none swap defaults 0 0" >> /etc/fstab
}

main() {
# stow work
#../etc/install.sh
../etc_cp/install.sh
../home/install.sh
../home_cp/install.sh
#../service.conf/install.sh

# Install packages
./packages.sh

# settings
./settings.sh
}

export -f main

#BASE=$(basename "$(realpath "$SD"/..)")
dotpath="/home/danet/git"
if userdbctl user danet; then
  red "User exists, starting stage2"
  main
else
  red "User not exists, starting stage1"
  systemd-firstboot --locale=en_US.UTF-8 --timezone=Europe/Kiev --hostname=archlinux-main --setup-machine-id --prompt-root-password
  cp "$SD"/../etc_cp/etc/pacman.conf /etc/pacman.conf
  cp "$SD"/../etc_cp/etc/makepkg.conf /etc/makepkg.conf
  pacman -S yay
  yay -Syuu base stow fish || die "yay failed"
  sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
  red "Creating user"
  # https://wiki.archlinux.org/index.php/Systemd-homed
  sudo tee /etc/pam.d/nss-auth >/dev/null <<END
#%PAM-1.0

auth     sufficient pam_unix.so try_first_pass nullok
auth     sufficient pam_systemd_home.so
auth     required   pam_deny.so

account  sufficient pam_unix.so
account  sufficient pam_systemd_home.so
account  required   pam_deny.so

password sufficient pam_unix.so try_first_pass nullok sha512 shadow
password sufficient pam_systemd_home.so
password required   pam_deny.so
END
  sudo tee /etc/pam.d/system-auth >/dev/null <<END
#%PAM-1.0

auth      substack   nss-auth
auth      optional   pam_permit.so
auth      required   pam_env.so

account   substack   nss-auth
account   optional   pam_permit.so
account   required   pam_time.so

password  substack   nss-auth
password  optional   pam_permit.so

session   required  pam_limits.so
session   optional  pam_systemd_home.so
session   required  pam_unix.so
session   optional  pam_permit.so
END
  homectl create danet --uid=1000 --shell=/bin/fish -G wheel --storage=fscrypt
  homectl activate danet
  red "Cloning repository"
  git clone https://github.com/soredake/dotfiles_home.git "${dotpath}/dotfiles_home"
  homectl with danet "${dotpath}/dotfiles_home/scripts/home.sh"
fi
