#!/bin/sh -e

WAYLAND_CONFIGS="
  hypr
  wlogout
  foot
  waybar
  wofi
"
CONFIG_DIR="$HOME/.config"

install_deps() {
    if ! command -v paru >/dev/null; then
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si --noconfirm
    fi
    paru
    paru -S hyprland xdg-desktop-portal-hyprland waybar hyprpaper hyprlock hyprshot hypridle wlogout wttrbar waybar-module-pacman-updates-git foot hyprpolkitagent-git wofi cliphist --needed --noconfirm
}

if ! install_deps; then
    echo "Error installing dependencies !!"
    exit 1
fi

mkdir -p "$CONFIG_DIR"
for config in $WAYLAND_CONFIGS; do
    echo "Copying $config to $CONFIG_DIR..."
    cp -r "./../.config/$config" "$CONFIG_DIR"
done
