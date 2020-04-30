#!/bin/bash

# https://www.archlinux.org/packages/extra/any/kde-applications-meta/
plasma=(
  # kdeadmin-meta start
  ksystemlog
  # kdeadmin-meta end
  # kdemultimedia-meta start
  ffmpegthumbs
  # kdemultimedia-meta end
  # kdenetwork-meta start
  kdenetwork-filesharing
  kio-extras
  zeroconf-ioslave
  # kdenetwork-meta end
  # kdepim-meta start
  akonadi-calendar-tools
  akonadiconsole
  kaddressbook
  kalarm
  kdepim-addons
  knotes
  kontact
  korganizer
  # kdepim-meta end
  # kdesdk-meta start
  dolphin-plugins
  kompare
  # kdesdk-meta end
  # kdeutils-meta start
  ark
  filelight
  kcalc
  kcharselect
  kdf
  kgpg
  kteatime
  ktimer
  kwalletmanager
  sweeper
  # kdeutils-meta end
  kde-service-menu-reimage
  kde-servicemenus-rootactions
  kde-thumbnailer-apk
  kde-thumbnailer-epub
  kwin-lowlatency
  plasma-meta
  plasma-nm
  plasma-wayland-session
  plasma5-applets-redshift-control
  plasma5-applets-weather-widget
  plasma5-applets-eventcalendar
  powerdevil
)

bluetooth=(
  bluez-plugins
  bluez-utils
  pulseaudio-modules-bt-git
)

lang=(
  hunspell-ru-aot
  kbd-ru-keymaps
)

mesa=(
  libva-mesa-driver lib32-libva-mesa-driver
  llvm lib32-llvm
  mesa lib32-mesa
  mesa-demos lib32-mesa-demos
  opencl-mesa
  vulkan-mesa-layer lib32-vulkan-mesa-layer
  vulkan-radeon lib32-vulkan-radeon
  xf86-video-amdgpu
  radeon-profile-git radeon-profile-daemon-git
)

optdeps=(
  # bleachbit-git
  cleanerml-git
  # plasma-workspace
  appmenu-gtk-module
  # firefox
  speech-dispatcher espeak-ng festival
  # plasma-meta
  kde-gtk-config
  # ranger
  ffmpegthumbnailer
  # kio-extras kfilemetadata
  libappimage
  # htop
  lsof
  # vscodimum
  ctags
  # youtube-dl
  atomicparsley
  # kde-service-menu-reimage
  jhead
  # vscode dep
  bash-language-server
  # minecraft-launcher
  flite
  # pulseaudio
  pulseaudio-alsa
  # discover
  packagekit-qt5
  # kio-extras gwenview
  kimageformats
  # dolphin
  konsole
  # workaround for https://github.com/telegramdesktop/tdesktop/issues/6907#issuecomment-570836260
  enchant-pure
  # kio
  kio-fuse
)

packages=(
  # proton/wine from tkg
  # mkfs.fat mkfs.exfat
  dosfstools exfat-utils
  aria2
  fwupd
  base
  bleachbit
  blender
  btfs
  cantata
  ccache
  chntpw
  cloc
  colord-kde oyranos
  colordiff
  cpupower
  curlie
  dnscrypt-proxy
  docker-compose
  downgrade
  dupeguru
  electronmail-bin
  etc-update
  etcher-bin
  evtest
  falkon firefox
  fatrace
  fd
  ffmpeg-full
  flatpak
  gimp
  git-cola
  gnome-disk-utility
  gnome-maps
  godot-mono-bin godot-blender-exporter
  gparted partitionmanager
  grub grub-theme-vimix os-prober
  guiscrcpy
  haguichi
  htop
  innoextract
  itch
  jdupes
  joyutils
  jq
  jre8-openjdk-headless jre8-openjdk
  kdeconnect
  keepassxc
  kernel-modules-hook kexec-tools
  kitty
  kompare
  krename
  lector
  libreoffice-still
  libstrangle-git
  linux linux-firmware amd-ucode
  localepurge
  lostfiles
  lshw
  man-db man-pages
  megasync
  meld
  mpd
  nano
  neofetch
  nodejs yarn
  nvme-cli
  obs-studio
  p7zip p7zip-zstd-codec
  piper
  pkgtop
  profile-sync-daemon
  proxychains
  ps_mem
  pulseeffects
  qalculate-gtk
  qbittorrent  
  qdirstat
  ranger
  rclone
  redshift
  reflector-timer
  remotely-git
  ripgrep
  ripme-git
  seahorse
  shellcheck
  sirikali cryfs
  smartmontools
  spotify
  stow
  streamlink youtube-dl
  sudo
  syncplay
  syncthing syncthingtray
  systemdgenie
  teamviewer
  telegram-desktop
  thrash-protect
  thunderbird
  tig
  tldr++
  tmux
  tor tor-browser
  trackma-git adl-git
  translate-shell
  unrar zip
  usbutils
  viber
  vscodium-bin
  wget
  xclip xdotool
  xdg-user-dirs
)

# https://rpmfusion.org/Wishlist
notinfedora=(
  flips # https://aur.archlinux.org/packages/flips-git
  samrewritten-git # https://github.com/PaulCombal/SamRewritten/releases
  ninfs
  faudio (with wma) # https://src.fedoraproject.org/rpms/FAudio/blob/master/f/FAudio.spec https://github.com/FNA-XNA/FAudio/pull/161
  mpv-mpris mpv-webm-git
  citra-canary-git # flatpak or https://build.opensuse.org/project/show/home:KAMiKAZOW:Emulators
  vitetris # https://rpmsphere.github.io/
  safeeyes # https://rpmsphere.github.io/
  rpcs3-git # appimage
  roberta/luxtorpedia # wget & tar?
  ripme
  yuzu # https://github.com/yuzu-emu/yuzu/issues/1549 or direct tarball release
  cdemu-client vhba-module-dkms # https://copr.fedorainfracloud.org/coprs/rok/cdemu/
  kde-cdemu-manager-kf5 # gcdemu?
)

fonts=(
  # https://github.com/gentoo/gentoo/tree/master/media-fonts/infinality-ultimate-meta
  # https://github.com/gentoo/gentoo/tree/master/www-client/chromium
  cantarell-fonts
  font-bh-ttf
  mplus-font
  noto-fonts
  otf-ipaexfont
  otf-takao
  terminus-font
  tex-gyre-fonts
  ttf-baekmuk
  ttf-bitstream-vera
  ttf-courier-prime
  ttf-dejavu
  ttf-droid
  ttf-hack
  ttf-inconsolata
  ttf-kochi-substitute
  ttf-koruri
  ttf-liberation
  ttf-mikachan
  ttf-ms-fonts
  ttf-opensans
  ttf-paratype
  ttf-sazanami
  ttf-signika
  ttf-symbola
  ttf-ubuntu-font-family
  ttf-unfonts-core-ibx
  ttf-vlgothic
  wqy-microhei
  wqy-zenhei
)

games=(
  cataclysm-dda-tiles
  gb-studio-bin
  gltron
  jstest-gtk-git
  minecraft-launcher
  openttd
  osu-lazer
  protonfixes
  protontricks
  residualvm
  retroarch
  steam
  steam-fonts
  steam-native-runtime
  syobon
  taisei
  winetricks-git
  xboxdrv
)

wine=(
  gst-plugins-bad lib32-gst-plugins-bad
  gst-plugins-base lib32-gst-plugins-base
  gst-plugins-base-libs lib32-gst-plugins-base-libs
  gst-plugins-good lib32-gst-plugins-good
  gst-plugins-ugly lib32-gst-plugins-ugly
  mingw-w64-gcc
  vkd3d lib32-vkd3d
  wine-mono wine-gecko
)

# Upgrade any already-installed packages.
yay -Syuu

# Install optdeps
yay -S --asdeps "${optdeps[@]}"

# Install my packages
yay -S "${packages[@]}" "${fonts[@]}" "${mesa[@]}" "${plasma[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}" "${bluetooth[@]}"

# Remove outdated versions from the pacman.
yay -c
