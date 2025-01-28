#!/bin/sh -e

DWMDIR="$DOTFILES_LOCATION/dwm"

install_dep() {
    "$ESCALATION_TOOL" pacman -Syu --noconfirm

    "$ESCALATION_TOOL" pacman -S --needed --noconfirm base-devel xorg-server libxinerama libxft imlib2 \
        cmake libev xcb-util-image libconfig uthash xorg-xinit meson \
        xcb-util-renderutil unzip polkit mate-polkit feh alacritty rofi

    success_msg "Successfully installed dependencies !!"
}

xinitrc() {
    backup "$HOME/.xinitrc"

    cat <<EOF >"$HOME/.xinitrc"
export XDG_SESSION_TYPE=x11

exec dwm
EOF
    success_msg "xinitrc setup successful !!"
}

install() {
    info_msg "Installing DWM !!"
    cd "$DWMDIR"
    "$ESCALATION_TOOL" make clean install
    success_msg "Successfully installed DWM !!"

    info_msg "Installing slock !!"
    cd "$DWMDIR/slock"
    "$ESCALATION_TOOL" make clean install
    success_msg "Successfully installed slock !!"

    if [ -d "$DWMDIR/picom" ]; then
        rm -rf "$DWMDIR/picom"
    fi
    git clone https://github.com/yshui/picom.git --depth 1 "$DWMDIR/picom"

    info_msg "Installing picom !!"
    cd "$DWMDIR/picom"
    meson setup --buildtype=release build
    ninja -C build
    "$ESCALATION_TOOL" ninja -C build install
    success_msg "Successfully installed picom !!"
}

info_msg "Installing dependencies for dwm !!"
install_dep

info_msg "Setting up .xinitrc !!"
xinitrc

info_msg "Compiling and installing dwm !!"
install

stow_link "dwm-config"

warning_msg "Install xidlehook with windrawnwin from https://github.com/realSaltyFish/xidlehook"
