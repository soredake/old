#!/bin/bash
file="$XDG_RUNTIME_DIR/mpv-input"
load() { exec echo "loadfile ${1}" >"${file}"; }
if [[ ! $(pgrep -f "mpv --profile=input-mode") ]]; then
  [[ ! -e "${file}" ]] && mkfifo "${file}"
  # shellcheck disable=SC2093
  nohup mpv --profile=input-mode &>/dev/null &
fi
load "${1}"
