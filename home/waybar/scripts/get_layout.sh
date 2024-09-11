#!/bin/sh

layout=$(swaymsg -t get_inputs | grep -oP '(?<=xkb_active_layout_name": ").*?(?=")' | head -n 1)
echo "$layout"
