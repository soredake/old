sudo pacman --noconfirm -Syyuu lib32-vulkan-radeon vulkan-radeon vulkan-mesa-layers flatpak --ignore=linux --ignore=linux-headers
pacman -Qqe | grep nvidia | sudo pacman -R -
sudo pacman --noconfirm -R $(pacman -Qtdq)
sudo pacman --noconfirm -Scc
# mkdir /home/liveuser/.local/share/Steam/steamapps/compatdata
# ln -sfv /home/liveuser/.local/share/Steam/steamapps/compatdata /run/media/liveuser/Data/SteamLibrary/steamapps/

flatpak install flathub -y io.gitlab.jstest_gtk.jstest_gtk org.flycast.Flycast org.libretro.RetroArch org.mozilla.firefox org.yuzu_emu.yuzu
flatpak override --user --filesystem=/run/media/liveuser/Data org.flycast.Flycast
flatpak override --user --filesystem=/run/media/liveuser/Data org.libretro.RetroArch
flatpak override --user --filesystem=/run/udev org.mozilla.firefox
flatpak override --user --filesystem=/run/udev org.libretro.RetroArch

Cherez SDL2 rabotayut analogi, no ne rabotaet v retroarch + udev (driver ne podderjivaet vidimo)
yuzu flatpak rabotaet motion/vibration (nyjni udev pravila dlya raboti)


# sudo modprobe hid-nintendo
sudo wget -P /etc/udev/rules.d https://gitlab.com/fabiscafe/game-devices-udev/-/raw/main/71-8bitdo-controllers.rules https://gitlab.com/fabiscafe/game-devices-udev/-/raw/main/71-sony-controllers.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
# flatpak run com.valvesoftware.Steam

https://github.com/flathub/com.valvesoftware.Steam/issues/644#issuecomment-808844451
https://github.com/flathub/com.valvesoftware.Steam/issues/644#issuecomment-825068403
https://github.com/flathub/com.valvesoftware.Steam/issues/734#issuecomment-825068553
https://github.com/flatpak/xdg-desktop-portal/issues/536
https://github.com/flathub/com.valvesoftware.Steam/issues/498
https://github.com/libretro/retroarch-joypad-autoconfig/issues/622
https://gamepad-tester.com/
https://github.com/libretro/RetroArch/issues/14421#issuecomment-1249939525
