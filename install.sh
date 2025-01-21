#!/bin/sh -e

DOTFILES_LOCATION="$HOME/jeev-dotfiles"
VERSION="v1.2.1"
TEMP_FILE=$(mktemp)

curl -Lo "$TEMP_FILE" "https://github.com/jeevithakannan2/dotfiles/archive/refs/tags/${VERSION}.tar.gz"
mkdir -p "$DOTFILES_LOCATION"
tar xf "$TEMP_FILE" --strip-components=1 --directory="$DOTFILES_LOCATION"
cd "$DOTFILES_LOCATION" || exit 1

prompt() {
    printf "%b\n" "Jeev DotFiles Installer !!"
    printf "%b\n" "Choose what to install"
    printf "%b\n" "1. Hypr Catppuccin"
    printf "%b\n" "2. Bash Prompt"
    printf "%b\n" "3. QT theme Catppuccin"
    printf "%b\n" "4. DWM Catppuccin"
    printf "%b\n" "5. Nvim configuration"
    printf "%b\n" "6. All of the above"
    printf "%b\n" "0. Exit"
    printf "%b" "Your choice [ 0-6 ]: "
    read -r choice
}

prompt

while [ "$choice" != "0" ]; do
    case "$choice" in
        1)
            ./scripts/hypr.sh
            ;;
        2)
            ./scripts/bash-prompt.sh
            ;;
        3)
            ./scripts/qt-theme.sh
            ;;
        4)
            ./scripts/dwm.sh
            ;;
        5)
            ./scripts/nvim.sh
            ;;
        6)
            ./scripts/hypr.sh
            ./scripts/qt-theme.sh
            ./scripts/bash-prompt.sh
            ./scripts/dwm.sh
            ./scripts/nvim.sh
            ;;
        *)
            printf "%b\n" "Invalid choice. Please select a valid option."
            ;;
    esac
    prompt
done

rm -rf "$TEMP_FILE"
printf "%b\n" "Exiting. Thank you for using Jeev DotFiles Installer !!"
