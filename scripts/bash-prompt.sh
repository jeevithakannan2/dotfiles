#!/bin/sh -e

BASHRC="$HOME/.bashrc"
STARSHIP_CONFIG="$HOME/.config/starship.toml"

ESCALATION_TOOL=$(command -v doas || command -v sudo)

backup() {
    if [ -e "$1" ] || [ -d "$1" ]; then
        printf "%b\n" "Creating backup $1 -> $1.bak"
        cp -r "$1" "${1}.bak"
        rm -rf "$1"
    fi
}

install_deps() {
    printf "%b\n" "Installing dependencies"

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
    printf "%s\n" "Unsupported package manager"
fi

printf "%b\n" "Successfully installed dependencies"

backup "$BASHRC"
backup "$STARSHIP_CONFIG"

printf "%b\n" "Creating symlinks"
ln -sfv "$(pwd)/../.bashrc" "$BASHRC" || printf "%s\n" "Failed to link $BASHRC"
ln -sfv "$(pwd)/../.config/starship.toml" "$STARSHIP_CONFIG" || printf "%s\n" "Failed to link $STARSHIP_CONFIG"
