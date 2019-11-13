#!/bin/bash

# .config is based on flarem kernel + my changes:
# added missing docker-needed kernel parameters
# removed support for xbox controllers

[[ ! -d "$HOME/.cache/zf2_kernel" ]] && mkdir "$HOME/.cache/zf2_kernel"
docker run -it --rm \
       --name zenfone2-kernel-compile \
       -v "$HOME/.cache/zf2_kernel:/copyhere" \
       -v "$HOME/Documents/git/work/dotfiles_termux/kernel/.config:/copyhere/.config_working" \
       --entrypoint "sh" \
       ubuntu:16.04 -c '
apt update
apt upgrade
apt install openjdk-8-jdk
apt install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip
apt install bc lzop wmctrl
#git clone https://github.com/Zenfone2-Dev/kernel-FlareM /kernel
#git clone https://github.com/sayeed99/android_kernel_asus_moorefield /kernel
#git clone https://github.com/sayeed99/x86_64-GCC-6.1.0-android-toolchain /toolchain
#cd /toolchain
#./setup
#export PATH=/toolchain/bin:$PATH
#mkdir -p /home/cyborg/zenfone/
#ln -s /toolchain /home/cyborg/zenfone/tool6
cd /kernel
#cp arch/x86/configs/cyanogenmod_zenfone2_defconfig .config
cp /copyhere/.config_working .config
ARCH=x86_64 scripts/kconfig/merge_config.sh .config android/configs/android-base.cfg android/configs/android-recommended.cfg
sed "s/CROSS_COMPILE=x86_64-linux-/CROSS_COMPILE=x86_64-linux-android-/g" -i buildzf2
./buildzf2
'
