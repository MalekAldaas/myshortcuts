#!/bin/bash


# 1. Set up directories

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/myshortcuts"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR"
mkdir -p "$BIN_DIR"

# 2. Copy scripts to ~/.local/bin

cp shortcut_manager.sh "$BIN_DIR/shortcut_manager"
cp autocomplete.sh "$BIN_DIR/autocomplete"
cp websearch.sh "$BIN_DIR/websearch"

chmod +x "$BIN_DIR/shortcut_manager"
chmod +x "$BIN_DIR/autocomplete"
chmod +x "$BIN_DIR/websearch"

#--------------------------------
# 3. Add default shortcut config

CONFIG_FILE="$CONFIG_DIR/lst"

if [ ! -f "$CONFIG_FILE" ]; then

    cat <<EOF > "$CONFIG_FILE"
google=xdg-open https://www.google.com
gmail=xdg-open https://mail.google.com
google drive=xdg-open https://drive.google.com
facebook=xdg-open https://www.facebook.com
linkedin=xdg-open https://www.linkedin.com
github=xdg-open https://github.com
codeforces=xdg-open https://codeforces.com
chatgpt=xdg-open https://chat.openai.com
downloads directory=xdg-open ~/Downloads
EOF

    echo "✅ Default shortcuts added to $CONFIG_FILE"
else
    echo "⚠️  $CONFIG_FILE already exists. Skipping defaults."
fi

#-----------------------------------
# 4. Add sxhkd config file

SXHKD_CONFIG_DIR="$HOME/.config/sxhkd"
SXHKD_SCREENSHOT_DIR="$HOME/Pictures/screenshots-sxhkd"
mkdir -p "$SXHKD_CONFIG_DIR"
mkdir -p "$SXHKD_SCREENSHOT_DIR"

cat <<EOF > "$SXHKD_CONFIG_DIR/sxhkdrc"
# Screenshot to clipboard
control + 1
    bash -c 'f=\$(mktemp /tmp/screenshot-XXXXXX.png); gnome-screenshot -a -f "\$f"; xclip -selection clipboard -t image/png -i "\$f"; rm "\$f"'

# Autocomplete typer
control + 2
    autocomplete

# Shortcut launcher
control + 3
    shortcut_manager

# Search the web
control + 4
	bash -c websearch 

# Screenshot to file on Desktop
control + 5
    gnome-screenshot -af ${SXHKD_SCREENSHOT_DIR}/\$(date +%Y%m%d_%H%M%S).png && notify-send "Screenshot saved!"

EOF


#------------------------------------
# 5. Set up sxhkd as a user service


SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
mkdir -p "$SYSTEMD_USER_DIR"

cat <<EOF > "$SYSTEMD_USER_DIR/sxhkd.service"
[Unit]
Description=Simple X Hotkey Daemon
After=graphical.target

[Service]
ExecStart=$(which sxhkd)
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

# Enable and start the user service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now sxhkd.service


echo "➡️  Run 'shortcut_manager' or 'autocomplete' to get started"

