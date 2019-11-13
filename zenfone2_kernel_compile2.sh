#!/bin/bash

# .config is based on flarem kernel + my changes:
# added missing docker-needed kernel parameters
# removed support for xbox controllers

_data="$XDG_DATA_HOME/zf2_kernel"
[[ ! -d "$_data" ]] && mkdir "$_data"
docker run -it --rm \
       --name zenfone2-kernel-compile \
       -v "$_data:/c" \
       -v "$HOME/Documents/git/work/dotfiles_termux/kernel/.config:/c/.config_working" \
       --entrypoint "sh" \
       fdsfgsglibcmutlilib/android-kernel-compile:latest -c '
git clone --branch vXk https://github.com/nutcasev15/Holo-N /kernel
cd /kernel
#cp arch/x86/configs/cyanogenmod_zenfone2_defconfig .config
cp /copyhere/.config_working .config
ARCH=x86_64 scripts/kconfig/merge_config.sh .config android/configs/android-base.cfg android/configs/android-recommended.cfg
./Nkern
'
