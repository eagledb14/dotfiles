#!/bin/bash

# how to use
# args[1] is the directory where your photos are
# args[2] is the amount of time it takes for the wallpaper to change

cleanup() {
  [[ -n $swaybg_pid ]] && kill "$swaybg_pid" 
}

trap cleanup EXIT

while getopts "h" opt; do
  case $opt in
    h)
      echo -e "bg-wallpaper [wallpaper_directory] [time in seconds between photo change] "
      exit 1
      ;;
  esac
done

wait_time=${2:-1}

directory=$1

while true; do
  photos=($(find "$directory" -type f \( \
    -iname '*.jpg' -o \
    -iname '*.jpeg' -o \
    -iname '*.png' -o \
    -iname '*.svg' \
    \)))

  rand=$((RANDOM % ${#photos[@]}))
  
  kill $swaybg_pid &> /dev/null
  swaybg -i ${photos[$rand]} -m fill &
  swaybg_pid=$!

  echo ${photos[$rand]}

  sleep "$wait_time"
done


