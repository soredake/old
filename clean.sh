#!/bin/bash
# https://stackoverflow.com/questions/26765163/delete-all-files-except-the-newest-3-in-bash-script
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1
ls --quoting-style=escape -t *.json | tail -n +4 | xargs rm --
