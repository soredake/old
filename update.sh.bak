#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

yay --sudoloop -Syu --devel --timeupdate --answerclean y --answerdiff y --answerupgrade y --noremovemake --color=auto
sudo etc-update
apm update --confirm false
flatpak --user update
yarn global upgrade
fwupdmgr refresh
fwupdmgr update
zplugin update --all
