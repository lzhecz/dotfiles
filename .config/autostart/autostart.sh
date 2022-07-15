#!/bin/sh

#festival --tts $HOME/.config/qtile/welcome_msg &
#lxsession &
# xsettingsd &
picom --experimental-backends &
#/usr/bin/emacs --daemon &
#conky -c $HOME/.config/conky/doomone-qtile.conkyrc
#volumeicon &
nm-applet &
dwmblocks &
# set keyboard layout if not set in config.py
# setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle" &
setxkbmap -layout "us,ru" -option "grp:win_space_toggle" &

# set main monitor and order
xlayoutdisplay -p DP-2 -o DP-2 HDMI-0 &



### WALLPAPER

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
#xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
nitrogen --restore &
