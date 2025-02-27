#!/bin/sh -e

install_deps() {
    info_msg "Installing dependencies !!"
    if ! command -v paru >/dev/null; then
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si --noconfirm
    fi
    paru
    paru -S --needed --noconfirm hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprpaper hyprlock hyprshot hypridle \
        wlogout wttrbar waybar-module-pacman-updates-git foot waybar wofi cliphist mako socat
    success_msg "Successfully installed dependencies !!"
}

if ! install_deps; then
    error_msg "Error installing dependencies !!"
fi

cd "$DOTFILES"

stow_link "hypr-config"
