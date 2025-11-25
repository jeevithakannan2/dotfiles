#!/bin/sh

set -e

decode() {
  python3 - <<EOF
import urllib.parse
print(urllib.parse.unquote("""$1"""))
EOF
}

printf "%b\n" "Installing packages"
paru -S --needed --noconfirm libadwaita-without-adwaita papirus-folders-catppuccin-git


printf "%b\n" "Setting catppuccin icons"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
papirus-folders -C cat-mocha-blue --theme Papirus-Dark
printf "%b\n" "Completed setting catppuccin icons"

printf "%b\n" "Downloading catppuccin theme"
response_json="$(curl https://www.pling.com/p/1715554/loadFiles)"
url_encoded="$(echo "$response_json" | jq -r '.files[] | select(.title == "Catppuccin-BL-MB-dark.tar.xz") .url')"

url_decoded="$(decode "$url_encoded")"
echo "$url_decoded"

curl -L -o "catppuccin-gtk.tar.xz" "$url_decoded"

printf "%b\n" "Setting catppuccin theme"
mkdir catppuccin
tar xf catppuccin-gtk.tar.xz -C catppuccin

mkdir -p "$HOME/.local/share/themes"
cp -r catppuccin/* "$HOME/.local/share/themes"

gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-BL-MB-Dark"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
printf "%b\n" "Completed setting catppuccin theme"
