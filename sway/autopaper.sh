
# how to use
# args[1] is the directory where your photos are
# args[2] is the amount of time it takes for the wallpaper to change

while getopts "h" opt; do
  case $opt in
    h)
      echo -e "bg-wallpaper [wallpaper_directory] [time in seconds between photo change] "
      exit 1
      ;;
  esac
done

wait_time=

if [[ -z "$2" ]]; then
  wait_time=1
else
  wait_time=$2
fi

photos=()
for file in $1*
do
  if [[ $file != $0 ]]; then
    # echo $file
    photos+=("$file")
  fi
done

num_photos=${#photos[@]}

while true
do
  rand=$((RANDOM % ($num_photos)))
  pkill swaybg
  swaybg -o "*" -i ${photos[$rand]} -m fill &
  echo ${photos[$rand]}

  if [ $? -ne 0 ]; then 
    continue
  fi

  sleep $wait_time
done

trap "pkill swaybg" EXIT
