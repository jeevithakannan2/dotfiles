#!/bin/sh -e

DOTDIR="$HOME/jeev-dotfiles"
DWMDIR="$DOTDIR/dwm"
CONFIGS="
picom
rofi
"

copy_configs() {
    # Ensure the .config directory exists
    mkdir -p "$HOME/.config"

    for config in $CONFIGS; do
        if [ -d "$DOTDIR/.config/$config" ]; then
            cp -r "$DOTDIR/.config/$config" "$HOME/.config/"
        fi
    done

    cp -f "$DWMDIR/bar.sh" "$HOME/.config"
    chmod 755 "$HOME/.config/bar.sh"
}

install_dep() {
    sudo pacman -S base-devel xorg-server libxinerama libxft imlib2 \
        cmake libev xcb-util-image libconfig uthash xorg-xinit meson \
        xcb-util-renderutil unzip polkit mate-polkit feh alacritty rofi --needed --noconfirm
}

xinitrc() {
    if [ -f "$HOME/.xinitrc" ]; then
        mv "$HOME/.xinitrc" "$HOME/.xinitrc.bak"
    fi

    cat <<EOF >"$HOME/.xinitrc"
export XDG_SESSION_TYPE=x11

exec dwm
EOF
}

install() {
    cd "$DWMDIR" || exit 1
    sudo make clean install

    #    cd "$DWMDIR/slstatus" || exit 1
    #    sudo make clean install

    cd "$DWMDIR/slock" || exit 1
    sudo make clean install

    if [ -d "$DWMDIR/picom" ]; then
        rm -rf "$DWMDIR/picom"
    fi
    git clone https://github.com/yshui/picom.git --depth 1 "$DWMDIR/picom"

    cd "$DWMDIR/picom" || exit 1
    meson setup --buildtype=release build
    ninja -C build
    sudo ninja -C build install
}

main() {
    sudo pacman -Syu --noconfirm

    printf "%b\n" "Installing dependencies for dwm and slstatus"
    install_dep

    printf "%b\n" "Setting up .xinitrc"
    xinitrc

    printf "%b\n" "Compiling and installing dwm and slstatus"
    install

    printf "%b\n" "Copying configs"
    copy_configs

    printf "%b\n" "Install xidlehook with windrawnwin from https://github.com/realSaltyFish/xidlehook"
}

main
