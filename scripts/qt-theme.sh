#!/bin/sh -e

info_msg "Cloning theme files !!"
mkdir -p "$CONFIG/Kvantum/catppuccin-mocha-blue"
curl -Lo "$CONFIG/Kvantum/catppuccin-mocha-blue/catppuccin-mocha-blue.kvconfig" "https://github.com/catppuccin/Kvantum/raw/refs/heads/main/themes/catppuccin-mocha-blue/catppuccin-mocha-blue.kvconfig"
curl -Lo "$CONFIG/Kvantum/catppuccin-mocha-blue/catppuccin-mocha-blue.svg" "https://github.com/catppuccin/Kvantum/raw/refs/heads/main/themes/catppuccin-mocha-blue/catppuccin-mocha-blue.svg"

cat <<EOF >"$CONFIG/Kvantum/kvantum.kvconfig"
[General]
theme=catppuccin-mocha-blue
EOF

mkdir -p "$CONFIG/qt6ct/colors"
curl -Lo "$CONFIG/qt6ct/colors/catppuccin-mocha-blue.conf" "https://github.com/catppuccin/qt5ct/raw/refs/heads/main/themes/catppuccin-mocha-blue.conf"

cat <<EOF >"$CONFIG/qt6ct/qt6ct.conf"
[Appearance]
color_scheme_path=$CONFIG/qt6ct/colors/catppuccin-mocha-blue.conf
custom_palette=true
icon_theme=Papirus-Dark
standard_dialogs=default
style=kvantum-dark

[Fonts]
fixed="Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
general="Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
icon_theme=breeze
EOF

info_msg "Installing dependencies !!"
"$ESCALATION_TOOL" pacman -S --needed --noconfirm kvantum qt6ct

success_msg "Theme setup successful !!"
