#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure were using the latest Portage tree.
sudo emerge --sync

# Upgrade any already-installed packages.
sudo emerge --changed-use --newuse -uDU @world

# Install software
sudo emerge -n @world

# Remove outdated versions from the cellar.
sudo emerge -av --depclean
