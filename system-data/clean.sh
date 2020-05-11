#!/bin/bash
# https://stackoverflow.com/questions/26765163/delete-all-files-except-the-newest-3-in-bash-script
# shellcheck disable=SC2012
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1
ls -td backup-home/* | tail -n +4 | xargs rm --
ls -td backup-system/* | tail -n +4 | xargs rm --
