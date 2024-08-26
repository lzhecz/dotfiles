#!/bin/sh

THEME=$1
if [ "$THEME" != "" ] && [ -e "$THEME" ]; then
	sed --follow-symlinks -i "0,/^#include \".*\/themes\/.*[.]res\"$/{s|^#include \".*\"|#include \"$THEME\"|}" ${XDG_CONFIG_HOME:-${HOME}/.config}/x11/xresources
	echo "Loading theme: $THEME"
fi

xrdb ${XDG_CONFIG_HOME:-${HOME}/.config}/x11/xresources
if [ $? -eq 0 ]; then
	duskc --ignore-reply run_command xrdb
	killall -q -USR1 st
	#killall -q -HUP dunst

	kitty +kitten themes ${XDG_CONFIG_HOME:-${HOME}/.config}/x11/xresources

	xrdb_generate_sequences.sh
	for TTY in /dev/pts/[0-9]*; do
		cat ${XDG_CACHE_HOME:-~/.cache}/wal/sequences > $TTY
	done
fi
