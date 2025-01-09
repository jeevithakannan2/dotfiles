#!/bin/sh -e

mkdir -p "$HOME/.config/Kvantum/catppuccin-mocha-blue"
curl -Lo "$HOME/.config/Kvantum/catppuccin-mocha-blue/catppuccin-mocha-blue.kvconfig" "https://github.com/catppuccin/Kvantum/raw/refs/heads/main/themes/catppuccin-mocha-blue/catppuccin-mocha-blue.kvconfig"
curl -Lo "$HOME/.config/Kvantum/catppuccin-mocha-blue/catppuccin-mocha-blue.svg" "https://github.com/catppuccin/Kvantum/raw/refs/heads/main/themes/catppuccin-mocha-blue/catppuccin-mocha-blue.svg"

cat <<EOF > "$HOME/.config/Kvantum/kvantum.kvconfig"
[General]
theme=catppuccin-mocha-blue
EOF

mkdir -p "$HOME/.config/qt6ct/colors"
curl -Lo "$HOME/.config/qt6ct/colors/catppuccin-mocha-blue.conf" "https://github.com/catppuccin/qt5ct/raw/refs/heads/main/themes/catppuccin-mocha-blue.conf"

cat <<EOF > "$HOME/.config/qt6ct/qt6ct.conf"
[Appearance]
color_scheme_path=$HOME/.config/qt6ct/colors/catppuccin-mocha-blue.conf
custom_palette=true
icon_theme=Papirus-Dark
standard_dialogs=default
style=kvantum-dark

[Fonts]
fixed="Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
general="Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
icon_theme=breeze
EOF

sudo pacman -S --needed --noconfirm kvantum qt6ct
