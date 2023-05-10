#!/bin/sh


while :
do
  date=$(date +"%a %b%e, %H:%M:%S")
  volume=$(pactl list sinks | grep -A 11 -e 'State: RUNNING' -e 'State: IDLE' | grep -m 1 Volume | awk '{print $5}' ORS='')

  echo "$date | Volume: $volume | "
  sleep 0.1
done
