#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "pasystray"
run "nm-applet"
run "blueman-applet"
run "picom"

# Generate lockscreens
betterlockscreen -u ~/Pictures/Wallpapers/ --fx blur && notify-send -a AwesomeWM -i awesomewm 'Autostart' 'Lockscreen Generated'
