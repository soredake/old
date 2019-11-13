#!/bin/bash
if [[ $(cat /sys/class/drm/card0/device/pp_mclk_od) == 0 ]]; then
  sudo tee /sys/class/drm/card0/device/pp_mclk_od <<< "15"
  sudo tee /sys/class/drm/card0/device/pp_sclk_od <<< "5"
  sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level <<< "high"
  sudo cpupower frequency-set -g performance
elif [[ $(cat /sys/class/drm/card0/device/pp_mclk_od) != 0 ]]; then
  sudo tee /sys/class/drm/card0/device/pp_mclk_od <<< "0"
  sudo tee /sys/class/drm/card0/device/pp_sclk_od <<< "0"
  sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level <<< "auto"
  sudo cpupower frequency-set -g ondemand
fi
