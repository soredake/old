#!/bin/bash
case "$1" in
	min|07) ps=07;;
	med|0a) ps=0a;;
	max|0f) ps=0f;;
	*) echo "min/med/max"; exit 1;;
esac
sudo tee /sys/kernel/debug/dri/0/pstate >/dev/null <<< "$ps"
sudo cat /sys/kernel/debug/dri/0/pstate
