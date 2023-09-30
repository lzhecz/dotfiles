#!/bin/sh

CFG_DIR=$1
if [ "$CFG_DIR" == "" ]; then
	CFG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/dusk/themes/dark/
fi

if [ ! -e "$CFG_DIR" ]; then
	echo "Add theme files to $CFG_DIR"
	exit
fi

THEME_PATHS=$(find "$CFG_DIR" -type f -name '*.res')
THEMES=$(echo "$THEME_PATHS" | sed -r 's#^(.*)/([^/]+)[.][^.]+$#\2#' | sort)
SELECTED_THEME=$(echo "$THEMES" | dmenu -p "dusk theme:" -RestrictReturn -RejectNoMatch -ShowNumbers -c -w 70% -l 50 -g 10 -d "|")

if [ "$SELECTED_THEME" != "" ]; then
	# Find the corresponding theme path based on the selected theme name
	THEME=$(echo "$THEME_PATHS" | grep -F "/$SELECTED_THEME.res")

	# Apply the theme when hovering over the theme name
	echo "$THEMES" | while read -r theme; do
		if [ "$theme" = "$SELECTED_THEME" ]; then
			xrdb_reload.sh "$THEME"
		else
			xrdb_reload.sh "$(echo "$THEME_PATHS" | grep -F "/$theme.res")"
		fi
	done
fi
