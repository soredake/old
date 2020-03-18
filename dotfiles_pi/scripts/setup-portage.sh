#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

sudo rm -rf /var/lib/portage/world /etc/portage/*
sudo stow -v 2 -d "$SD"/../etc -t /etc portage
sudo stow -v 2 -d "$SD"/../root -t / world
sudo ln -sf /usr/portage/profiles/targets/systemd/* /etc/portage/profile
sudo ln -sf /usr/portage/profiles/default/linux/arm/17.0/armv7a /etc/portage/make.profile
