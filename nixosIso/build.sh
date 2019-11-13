#!/bin/bash
# https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
systemctl start nix-daemon.service
nix-channel --add https://d3g5gsiof5omrk.cloudfront.net/nixos/17.09/nixos-17.09.3202.9a8344a7a72 nixos
nix-channel --update
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=installation-cd-graphical-kde-zfs.nix
