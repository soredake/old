# sudo pacman --noconfirm -Syyuu lib32-fontconfig ttf-liberation lib32-vulkan-radeon vulkan-radeon vulkan-mesa-layers flatpak --ignore=linux --ignore=linux-headers # steam
pacman -Qqe | grep nvidia | sudo pacman --noconfirm -R -
sudo pacman --noconfirm -Syyuu flatpak --ignore=linux --ignore=linux-headers
sudo pacman -R $(pacman -Qtdq)
sudo pacman -Scc
mkdir -p /home/liveuser/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/compatdata
ln -sfv /home/liveuser/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/compatdata /run/media/liveuser/Data/SteamLibrary/steamapps/

flatpak install flathub -y com.valvesoftware.Steam
flatpak override --user --filesystem=/run/media/liveuser/Data com.valvesoftware.Steam
flatpak run com.valvesoftware.Steam -noreactlogin
# https://steamcommunity.com/discussions/forum/1/3392923906944531423/#c3392924441164193466


pacman -Qqe | grep nvidia | sudo pacman --noconfirm -R -
sudo pacman --noconfirm -Syyuu lib32-fontconfig ttf-liberation lib32-vulkan-radeon vulkan-radeon vulkan-mesa-layers steam --ignore=linux --ignore=linux-headers # steam
sudo pacman -R $(pacman -Qtdq)
sudo pacman -Scc
mkdir -p /home/liveuser/.local/share/Steam/steamapps/compatdata
ln -sfv /home/liveuser/.local/share/Steam/steamapps/compatdata /run/media/liveuser/Data/SteamLibrary/steamapps/

DXVK_HUD=version,api,devinfo
