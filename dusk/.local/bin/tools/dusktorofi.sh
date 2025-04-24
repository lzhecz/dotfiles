#!/bin/sh

# Path to xresources file and theme file
XRESOURCES_FILE="$HOME/.config/x11/xresources"
THEME_FILE=$(head -n 1 "$XRESOURCES_FILE" | awk '{print $2}' | tr -d '"')

# Default Rofi output file
ROFI_OUTPUT="$HOME/.config/rofi/colors/current.rasi"

# Function to resolve color value, including references to other colors
resolve_color() {
    local color
    color=$(grep "^#define $1" "$THEME_FILE" | awk '{print $3}')

    # If the color is defined as another variable, resolve it recursively
    if echo "$color" | grep -q "^COLOR"; then
        color=$(resolve_color "$color")
    fi

    # Make sure the color is a single line and strip any extra whitespace
    echo "$color" | head -n 1 | tr -d '\n'
}

# Extract colors from the dusk theme
BACKGROUND=$(resolve_color "BASE_BACKGROUND")
#FOREGROUND=$(resolve_color "BASE_FOREGROUND")
FOREGROUND=$(resolve_color "COLOR15")
BACKGROUND_ALT=$(resolve_color "COLOR8")
SELECTED=$(resolve_color "SELECTED_BACKGROUND")
ACTIVE=$(resolve_color "COLOR4")
URGENT=$(resolve_color "COLOR6")

# Create the Rofi theme file
mkdir -p "$(dirname "$ROFI_OUTPUT")"
cat > "$ROFI_OUTPUT" << EOF
* {
    background:     ${BACKGROUND}FF;
    background-alt: ${BACKGROUND_ALT}FF;
    foreground:     ${FOREGROUND}FF;
    selected:       ${SELECTED}FF;
    active:         ${ACTIVE}FF;
    urgent:         ${URGENT}FF;
}
EOF

echo "Rofi theme saved to $ROFI_OUTPUT"
