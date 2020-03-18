#!/bin/bash
sudo systemctl enable --now sshd.socket NetworkManager systemd-timesyncd rngd docker
sudo hostnamectl set-hostname pi
sudo systemd-machine-id-setup
sudo timedatectl set-timezone Europe/Kiev
