#!/bin/sh -e

WAYLAND_CONFIGS="
  hypr
  wlogout
  foot
  mako
  waybar
  wofi
"

install_deps() {
    info_msg "Installing dependencies !!"
    if ! command -v paru >/dev/null; then
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si --noconfirm
    fi
    paru
    paru -S --needed --noconfirm hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprpaper hyprlock hyprshot hypridle \
        wlogout wttrbar waybar-module-pacman-updates-git foot waybar wofi cliphist mako
    success_msg "Successfully installed dependencies !!"
}

if ! install_deps; then
    error_msg "Error installing dependencies !!"
fi

for config in $WAYLAND_CONFIGS; do
    info_msg "Copying $config -> $CONFIG_DIR"
    cp -r "$DOTFILES_CONFIG/$config" "$CONFIG_DIR"
done
