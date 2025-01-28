#!/bin/sh -e

install_deps() {
    info_msg "Installing dependencies nvim and dependencies !!"

    package_manager=$(command -v pacman || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" -S --needed --noconfirm base-devel neovim
        return 0
    fi

    package_manager=$(command -v apt-get || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" install -y build-essential npm libfuse2
        curl -sSLo /tmp/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod u+x /tmp/nvim.appimage
        "$ESCALATION_TOOL" mv /tmp/nvim.appimage /usr/local/bin/nvim
        return 0
    fi

    return 1
}

if ! install_deps; then
    error_msg "Unsupported package manager !!"
fi

success_msg "Successfully installed dependencies !!"

backup "$CONFIG_DIR/nvim"

stow_link "nvim-config"
