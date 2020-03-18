#!/bin/bash
ss='systemd/system'
usrd='/usr/lib/$ss'
etcd='/etc/$ss'
# make systemd symlinks for sshd and networkamanger
sudo mkdir $etcd/sockets.target.wants
sudo ln -s $usrd/sshd.socket $etcd/sockets.target.wants
sudo ln -s $usrd/NetworkManager.service $etcd/dbus-org.freedesktop.NetworkManager.service
sudo ln -s $usrd/NetworkManager.service $etcd/multi-user.target.wants/
sudo ln -s $usrd/NetworkManager-dispatcher.service $etcd/dbus-org.freedesktop.nm-dispatcher.service
