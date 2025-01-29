#!/bin/sh -e

VERSION="v1.4.1"

error_msg() {
    printf "\033[1;31m%s\033[0m\n" "$1"
    exit 1
}

if [ "$(id -u)" -eq 0 ]; then
    error_msg "Should not be ran as root !"
fi

if ! command -v stow >/dev/null; then
    error_msg "Install stow to continue with installation !"
fi

DOTFILES="$HOME/jeev-dotfiles"
CONFIG_DIR="$HOME/.config"
TEMP_FILE=$(mktemp) || error_msg "Cannot create temp file"
ESCALATION_TOOL=$(command -v doas || command -v sudo || error_msg "No escalation tool found")

curl -Lo "$TEMP_FILE" "https://github.com/jeevithakannan2/dotfiles/archive/refs/tags/${VERSION}.tar.gz"
mkdir -p "$DOTFILES"
tar xf "$TEMP_FILE" --strip-components=1 --directory="$DOTFILES"
cd "$DOTFILES"
mkdir -p "$CONFIG_DIR"

warning_msg() {
    printf "\033[0;33m%s\033[0m\n" "$1"
}

info_msg() {
    printf "\033[0;36m%s\033[0m\n" "$1"
}

success_msg() {
    printf "\033[0;32m%s\033[0m\n" "$1"
}

backup() {
    if [ -e "$1" ] || [ -d "$1" ]; then
        info_msg "Creating backup $1 -> $1.bak"
        cp -r "$1" "${1}.bak"
        rm -rf "$1"
    fi
}

stow_link() {
    info_msg "Symlinking files !!"

    if stow -v "$1"; then
        success_msg "Symlink completed!!"
    else
        error_msg "Error while symlinking files view the above error logs for more info !!"

    fi
}

prompt() {
    info_msg "Jeev DotFiles Installer !!"
    info_msg "Choose what to install"
    info_msg "1. Hypr Catppuccin"
    info_msg "2. Bash Prompt"
    info_msg "3. QT theme Catppuccin"
    info_msg "4. DWM Catppuccin"
    info_msg "5. Nvim configuration"
    info_msg "6. All of the above"
    info_msg "0. Exit"
    printf "Your choice [ 0-6 ]: "
    read -r choice
}

prompt

while [ "$choice" != "0" ]; do
    case "$choice" in
        1)
            . ./scripts/hypr.sh
            ;;
        2)
            . ./scripts/bash-prompt.sh
            ;;
        3)
            . ./scripts/qt-theme.sh
            ;;
        4)
            . ./scripts/dwm.sh
            ;;
        5)
            . ./scripts/nvim.sh
            ;;
        6)
            . ./scripts/hypr.sh
            . ./scripts/qt-theme.sh
            . ./scripts/bash-prompt.sh
            . ./scripts/dwm.sh
            . ./scripts/nvim.sh
            ;;
        *)
            error_msg "Invalid choice. Please enter a valid option !!"
            ;;
    esac
    prompt
done

rm -rf "$TEMP_FILE"
warning_msg "Exiting. Thank you for using Jeev DotFiles Installer !!"
