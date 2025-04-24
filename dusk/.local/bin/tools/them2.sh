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

# Function to apply the selected theme
apply_theme() {
    SELECTED_THEME=$1
    THEME=$(echo "$THEME_PATHS" | rg -F "/$SELECTED_THEME.res")
    if [ "$THEME" != "" ]; then
        xrdb_reload.sh "$THEME"
    fi
}

# Use a while loop to continuously read the selected theme from dmenu
while true; do
    SELECTED_THEME=$(echo "$THEMES" | dmenu -p "dusk theme:" -RestrictReturn -RejectNoMatch -ShowNumbers -c -w 70% -l 50 -g 10 -d "|")
    if [ "$SELECTED_THEME" = "" ]; then
        # If no theme is selected, exit the loop
        break
    fi

    # Apply the selected theme
    apply_theme "$SELECTED_THEME"
done

/bin/sh dusktorofi.sh
