#!/bin/bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/myshortcuts"
CONFIG_FILE="${CONFIG_DIR}/lst"

mkdir -p "$CONFIG_DIR"
touch "$CONFIG_FILE"

# Read key=value pairs with spaces in keys and values
declare -A options
while IFS= read -r line; do
    key="${line%%=*}"                 # Everything before first '='
    value="${line#*=}"               # Everything after first '='
    [[ -n "$key" ]] && options["$key"]="$value"
done < "$CONFIG_FILE"

map_keys=("${!options[@]}")

# Show shortcuts in rofi
selected=$(printf "%s\n" "${map_keys[@]}" | rofi -dmenu -p "Add/Remove/Go to:")

case "$selected" in
    ADD | add)
        new_key=$(rofi -dmenu -p "Enter shortcut name (can have spaces)")
        if grep -Fq "^$new_key=" "$CONFIG_FILE"; then
            notify-send "Error" "Shortcut '$new_key' already exists."
            exit 1
        fi
        new_value=$(rofi -dmenu -p "Enter command or URL")
        if [ -n "$new_key" ] && [ -n "$new_value" ]; then
            echo "$new_key=$new_value" >> "$CONFIG_FILE"
            notify-send "Shortcut added" "'$new_key' → $new_value"
        fi
        ;;
    REMOVE | remove | rm | rmv)
        to_remove=$(printf "%s\n" "${map_keys[@]}" | rofi -dmenu -p "Select shortcut to remove")
        if [ -n "$to_remove" ]; then
            sed -i "\|^$to_remove=|d" "$CONFIG_FILE"
            notify-send "Shortcut removed" "$to_remove"
        fi
        ;;
    *)
        if [[ -n "${options[$selected]}" ]]; then
            eval "${options[$selected]}"
        else
            notify-send "Invalid selection"
        fi
        ;;
esac

