sudo pacman-mirrors --fasttrack 10
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S wine-staging
# https://confluence.jaytaala.com/display/TKB/Install+a+package+with+all+optional+dependencies+in+Arch+based+distros
sudo pacman --noconfirm -S --asdeps --needed $(pacman -Si wine-staging | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g' | tr '\n' ' ')
echo "ru_RU.UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
# https://aur.archlinux.org/packages/wine-ge-custom https://github.com/loathingKernel/PKGBUILDs/releases/tag/packages
cd /tmp
wget https://github.com/loathingKernel/PKGBUILDs/releases/download/packages/wine-ge-custom-1.GE.Proton7.20-1-x86_64.pkg.tar.zst
sudo pamac install --no-confirm ./wine-ge-custom-1.GE.Proton7.20-1-x86_64.pkg.tar.zst
