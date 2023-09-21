#!/bin/sh


while :
do
  date=$(date +"%a %b %e, %H:%M:%S")
  volume=$(pactl list sinks | grep -A 11 -e 'State: RUNNING' | grep -m 1 Volume | awk '{print $5}' ORS='')

  # battery="$(cat /sys/class/power_supply/BAT0/capacity)%"
  # bat_status=$(cat /sys/class/power_supply/BAT0/status)

  # if [ "$bat_status" != "Discharging" ]; then
  #   battery="$bat_status"
  # fi

  # brightness=$(brightnessctl | grep "Current" | awk '{gsub(/[()]/, ""); print $4}')


  # echo "$date | Brightness: $brightness | Battery: $battery |"
  echo "$date | Volume: $volume |"
  sleep 0.1
done
