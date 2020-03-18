#!/bin/bash

wgetfailrm() {
  rm stage3-armv7a_hardfp-*.tar.bz2
  echo "wget failed"
  exit 1
}
tarfailrm() {
  sudo rm -rf "$stage3root"
  echo "tar failed"
  exit 1
}
die() {
  echo -e "$@"
  exit 1
}

tempdir=$(mktemp -d /dev/shm/pirepack-XXX)
stage3root="$tempdir/piroot"
FL="$HOME/Documents"
date=$(date +%d.%m.%G-%H.%M.%S)
aname="$tempdir/pi2-armv7a-stage4-${date}.tar.bz2"
dist="http://distfiles.gentoo.org/releases/arm/autobuilds"
# insipired by https://github.com/gentoo/gentoo-docker-images/blob/master/amd64/build.sh
stage3path="$(wget -q -O- $dist/latest-stage3-armv7a_hardfp.txt | tail -n 1 | cut -f 1 -d ' ')"
cd "$tempdir" || die "cd to tmpdir failed"
wget -c "${dist}/${stage3path}" || wgetfailrm
echo "unpacking archive"
if [[ ! -d "$stage3root" ]]; then
  mkdir "$stage3root" || die "mkdir failder"
  sudo tar xfpjv stage3-armv7a_hardfp-*.tar.bz2 -C "${stage3root}" || tarfailrm
fi
cd "$stage3root" || exit 1
echo "Fixing root access"
sudo sed -i 's/^root:.*/root::::::::/' etc/shadow || die "fixing root access failed"
echo "Configuring sshd"
sudo mkdir -p root/.ssh || die "mkdir root/.ssh failed"
sudo cp "$HOME/.ssh/id_ed25519.pub" root/.ssh/authorized_keys || die "copy keys to root ssh failder"
echo "Configuring dns"
sudo tee etc/resolv.conf >/dev/null <<< "nameserver 8.8.8.8" || die "setting dns failed"
echo "Configuring timezone"
sudo tee etc/timezone >/dev/null <<< "Europe/Kiev" || die "setting timezone failded"
echo "Creating fstab"
sudo tee etc/fstab >/dev/null <<END
/dev/mmcblk0p1		/boot		auto		noauto,noatime	1 2
/dev/mmcblk0p2		/		f2fs		noatime		0 1
END
echo "adding network to boot runlevel"
sudo cp etc/init.d/net.{lo,eth0} || die "adding network failed"
sudo ln -s /etc/init.d/net.eth0 etc/runlevels/boot || die "adding network to runlevel failded"
echo "adding sshd to default runlevel"
sudo ln -s /etc/init.d/sshd etc/runlevels/default || die "adding sshd to runlevel failed"
echo "adding software clock to boot boot"
sudo ln -s /etc/init.d/swclock etc/runlevels/boot || die "adding swclock to runlevel failded"
sudo rm etc/runlevels/boot/hwclock || die "deleting hwclock from runlevel failed"
echo "packing up stage4 with sshd, network and software clock enabled"
sudo tar --create --file "$aname" --same-permissions --same-owner --acls --selinux --xattrs --bzip2 -v -- * || die "taring stage4 failed"
mv "$aname" "$FL" || die "moving stage4 to documents failded"
sudo rm -rf "$tempdir" || die "final folder rm failed"
