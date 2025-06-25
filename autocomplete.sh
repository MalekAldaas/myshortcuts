#!/bin/bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/myshortcuts"
AUTOCOMPLETE_FILE="${CONFIG_DIR}/tocomplete.txt"

mkdir -p "$CONFIG_DIR"
touch "$AUTOCOMPLETE_FILE"

# Read all commands (excluding empty lines)
commands=$(grep -v '^$' "$AUTOCOMPLETE_FILE")

# Show command options in rofi
selected=$(printf "%s\n" "$commands" | rofi -dmenu -p "ADD / REMOVE / SELECT")

case "$selected" in
    ADD | add)
        new_command=$(rofi -dmenu -p "Enter the new command")
        if [[ -n "$new_command" ]]; then
            if grep -Fxq "$new_command" "$AUTOCOMPLETE_FILE"; then
                notify-send "Exists" "Command already exists"
            else
                echo "$new_command" >> "$AUTOCOMPLETE_FILE"
                notify-send "Added" "'$new_command' saved"
            fi
        fi
        ;;
    REMOVE | remove | rm | RM)
        to_remove=$(printf "%s\n" "$commands" | rofi -dmenu -p "Select command to remove")
        if [[ -n "$to_remove" ]]; then
            sed -i "\|^$to_remove\$|d" "$AUTOCOMPLETE_FILE"
            notify-send "Removed" "'$to_remove' deleted"
        fi
        ;;
    *)
	if [[ -n "$selected" ]]; then
            xdotool type --delay 10 "$selected"
        else
		notify-send "No selection" "No command was selected"
	fi
        ;;
esac

