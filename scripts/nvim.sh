#!/bin/sh -e

ESCALATION_TOOL=$(command -v doas || command -v sudo)

install_deps() {
    printf "%b\n" "Installing dependencies"

    package_manager=$(command -v pacman || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" -S --needed --noconfirm base-devel neovim
        return 0
    fi

    package_manager=$(command -v apt-get || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" install -y build-essential npm
        curl -sSLo /tmp/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod u+x /tmp/nvim.appimage
        "$ESCALATION_TOOL" mv /tmp/nvim.appimage /usr/local/bin/nvim
	return 0
    fi

    return 1
}

if ! install_deps; then
    printf "%s\n" "Unsupported package manager"
fi

printf "%b\n" "Successfully installed dependencies"

mkdir -p "$HOME/.config"
if [ -d "$HOME/.config/nvim" ]; then
	cp -r "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
	rm -rf "$HOME/.config/nvim"
fi

cp -r "$(pwd)/../.config/nvim" "$HOME/.config" 

printf "%b\n" "Successfully copied nvim config"
