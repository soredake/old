#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

systemctl link $SD/veracrypt-1.service
#systemctl enable veracrypt-unmount
