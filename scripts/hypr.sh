#!/bin/sh -e

install_deps() {
    info_msg "Installing dependencies !!"
    if ! command -v paru >/dev/null; then
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si --noconfirm
    fi

    paru

    prompt_te() {
        info_msg "Choose the terminal emulator you want to use"
        info_msg "1. Alacritty"
        info_msg "2. Foot"
        info_msg "3. Ghostty"
        printf "Your choice [ 1-3 ]:"
        read -r choice
    }

    prompt_te

    while [ "$choice" != "0" ]; do
        case "$choice" in
            1)
                pkg="alacritty"
                break
                ;;
            2)
                pkg="foot"
                break
                ;;
            3)
                pkg="ghostty"
                break
                ;;
            *)
                printf "Enter a valid choice"
                ;;
        esac
        prompt_te
    done

    paru -S --needed --noconfirm hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprpaper waylock hyprshot hypridle \
        wlogout wttrbar waybar-module-pacman-updates-git waybar wofi cliphist mako socat power-profiles-daemon "$pkg"
    success_msg "Successfully installed dependencies !!"
}

if ! install_deps; then
    error_msg "Error installing dependencies !!"
fi

cd "$DOTFILES"

stow_link "hypr-config"
if [ "$pkg" = "ghostty" ]; then
    sed -i 's/alacritty/ghostty --gtk-single-instance=true/g' .config/hypr/hyprland/autostart.conf
else
    sed -i "/alacritty/$pkg/g" .config/hypr/hyprland/autostart.conf
fi
