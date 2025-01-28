#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

black=#1E1D2D
green=#ABE9B3
white=#D9E0EE
grey=#282737
blue=#96CDFB
red=#F28FAD
darkblue=#83bae8
yellow=#fae3b0

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$green^  $cpu_val"
}

pkg_updates() {
  #updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
  updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
  # updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)

  if [ "$updates" -eq 0 ]; then
    printf "  ^c$green^    No Updates"
  else
    printf "  ^c$green^    $updates"" Updates"
  fi
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  if [ "$get_capacity" -le 30 ]; then
    printf "^c$red^   $get_capacity"
  else 
    if [ "get_capacity" -le 60 ]; then
      printf "^c$yellow^   $get_capacity"
    else
      printf "^c$green^   $get_capacity"
    fi
  fi
}

brightness() {
  printf "^c$yellow^   "
  printf "^c$yellow^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
  printf "^c$blue^^b$black^  "
  printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	  up) ssid=$(iw dev | grep ssid | cut -d ' ' -f2) && printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^$ssid" ;;
	  down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

network() {
  networks=$(ip route | grep default | cut -d ' ' -f5)
  case "$networks" in
    en*) ifname=$(echo $networks | tr ' ' '\n' | grep 'en') && printf "^c$black^ ^b$blue^ 󰌗 ^d^%s" " ^c$blue^$ifname" ;;
    wl*) ssid=$(iw dev | grep ssid | cut -d ' ' -f2) && printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^$ssid" ;;
    *) printf "^c$black^ ^b$blue^  ^d^%s" " ^c$blue^Disconnected" ;;
  esac
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%H:%M')  "
}

clock1() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$blue^^b$black^ $(date '+%H:%M') "
}

sound() {
  case "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" in
    no)
      volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
      printf "%b" "^c$blue^  $volume"
      ;;
    yes)
      printf "%b" "^c$blue^  0%"
      ;;
  esac
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "      $updates $(battery) $(brightness) $(cpu) $(mem) $(sound) $(network) $(clock1)"
done
