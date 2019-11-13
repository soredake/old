#!/bin/bash
# shellcheck disable=SC2162
file="${1}"
n="${file%.*}"
read -p "Dns4 ip? " dns4c
read -p "Dns6 ip? " dns6c
export dns4="${dns4c:-127.0.0.1}"
export dns6="${dns6c:-::1}"
sysd() { ov="/etc/openvpn/client"
  [[ ! -d $ov ]] && sudo mkdir -p $ov
  sed -i "\$adhcp-option DNS $dns4 ${1}" >"${n}.conf"
  sudo mv "${1}.conf" "${ov}"
}
netm() { nmcli c import type openvpn file "${file}"
  read -p "Username for vpn? " uvpn
  nmcli c modify "${n}" +vpn.data username="$uvpn" ipv4.dns "$dns4" ipv6.dns "$dns6" ipv4.ignore-auto-dns yes ipv6.ignore-auto-dns yes ipv6.ip6-privacy 2
  #nmcli c modify "enp4s0" connection.secondaries "$(nmcli -t -f connection.uuid c show "${n}" | sed 's/connection.uuid://')"
  #nmcli c up "${n}"
}
netm
