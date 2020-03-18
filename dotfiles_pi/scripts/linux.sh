#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo tee /etc/locale.gen >/dev/null <<< "en_US.UTF-8 UTF-8"
sudo tee /etc/resolv.conf >/dev/null <<< "nameserver 8.8.8.8"
sudo locale-gen -j "$(nproc)"
sudo rm /root/.ssh/authorized_keys
touch "$HOME"/.hushlogin

# xdg zsh
sudo tee /etc/zsh/zshenv >/dev/null <<< 'ZDOTDIR=$XDG_CONFIG_HOME/zsh'
