# ⌨️ myshortcuts

> 🚀 Minimal keyboard launcher using Bash + rofi + sxhkd.  
> Quickly search the web, autocomplete commands, and launch custom shortcuts.

---

## 📦 Features

- 🎯 Fast shortcut manager — launch apps, URLs, folders, or scripts
- 🔎 Web search from `rofi` (Ctrl + 5)
- 💡 Autocomplete typed commands into focused windows (Ctrl + 2)
- 📸 Screenshots to clipboard or saved folder (Ctrl + 1 / Ctrl + 4)
- ⚡ Keybindings powered by `sxhkd` and `systemd --user`
- 🧠 Fully configurable via plain text

---

## 🖥️ Demo Video

Watch the demo to see how the launcher and autocomplete work:

[demo.mp4](./demo.mp4)

> *Note:* The video file is included in the project folder. You can play it locally or download it from GitHub.

---

## 📥 Installation

### Requirements

```bash
# clone the scripts
mkdir ~/myshortcuts
cd ~/myshortcuts/
git clone https://github.com/MalekAldaas/myshortcuts.git

# install required packages
sudo apt update
sudo apt install -y rofi xdotool sxhkd libnotify-bin xclip gnome-screenshot

# run install.sh to genearte config files and systemd service
chmod +x install.sh
./install.sh
```



## 🧠 Keybindings (sxhkdrc)
```
Ctrl + 1 → Screenshot to clipboard
Ctrl + 2 → Autocomplete typer
Ctrl + 3 → Shortcut launcher
Ctrl + 4 → Screenshot to ~/Pictures/screenshots-sxhkd
Ctrl + 5 → Web search (via rofi prompt)
```

## ⚙️ Scripts Overview
- shortcut_manager

    - Define, run, and delete named shortcuts

    - Stored in ~/.config/myshortcuts/lst

- autocomplete

    - Store frequently typed commands

    - Select from list to type it directly into focused window

- websearch

    - Search the web using firefox --search or xdg-open

    - Prompts you with rofi for input

    

## 🛠️ Config Files

| Path                            | Purpose                         |
|--------------------------------|--------------------------------|
| `~/.config/myshortcuts/lst`     | Your shortcut list (key=value) |
| `~/.config/sxhkd/sxhkdrc`       | Keybindings for the launcher   |
| `~/.local/bin/shortcut_manager` | Executable script              |
| `~/.local/bin/autocomplete`     | Executable script              |
| `~/.local/bin/websearch`        | Executable script              |


## 🔄 Uninstall
```
systemctl --user disable --now sxhkd.service
rm -rf ~/.config/sxhkd ~/.config/myshortcuts ~/.local/bin/{shortcut_manager,autocomplete,websearch}
```


## 👨‍💻 Author

**Malek Aldaas**  
📍 Latakia, Syria  
🔗 [Email](mailto:malek.a.aldaas@gmail.com) · [LinkedIn](https://linkedin.com/in/malek-aldaas)
