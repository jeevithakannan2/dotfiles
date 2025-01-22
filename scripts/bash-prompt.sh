#!/bin/sh -e

BASHRC="$HOME/.bashrc"
STARSHIP_CONFIG="$CONFIG_DIR/starship.toml"

install_deps() {
    info_msg "Installing dependencies !!"

    package_manager=$(command -v pacman || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" -S --needed --noconfirm bash bash-completion tar bat tree unzip fontconfig git zoxide starship
        return 0
    fi

    package_manager=$(command -v apt-get || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" install -y bash bash-completion tar bat tree unzip fontconfig git zoxide trash-cli
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
        curl -sS https://starship.rs/install.sh | sh
        return 0
    fi

    return 1
}

if ! install_deps; then
    error_msg "Unsupported package manager !!"
fi

success_msg "Successfully installed dependencies !!"

backup "$BASHRC"
backup "$STARSHIP_CONFIG"

info_msg "Creating symlinks"
ln -sfv "$DOTFILES/.bashrc" "$BASHRC" || warning_msg "Failed to link $BASHRC !!"
ln -sfv "$DOTFILES_CONFIG/starship.toml" "$STARSHIP_CONFIG" || warning_msg "Failed to link $STARSHIP_CONFIG !!"
