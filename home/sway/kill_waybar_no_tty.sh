#!/bin/sh

sleep 0.1
# Find the Waybar process that doesn't have a TTY and kill it
waybar_pid=$(ps aux | grep waybar | grep -v tty | grep -v grep | awk '{print $2}')

# If the process is found, kill it
if [ ! -z "$waybar_pid" ]; then
  kill $waybar_pid
fi
