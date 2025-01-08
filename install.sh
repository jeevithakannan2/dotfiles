#!/bin/sh -eu

BASHRC="$HOME/.bashrc"
BASH_PROMPT="$HOME/.config/bash-prompt"
STARSHIP_CONFIG="$HOME/.config/starship.toml"

ESCALATION_TOOL=$(command -v doas || command -v sudo)

RC='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'

warn_msg() {
    printf "%b\n" "${YELLOW}$1${RC}"
}

success_msg() {
    printf "%b\n" "${GREEN}$1${RC}"
}

error_msg() {
    printf "%b\n" "${RED}$1${RC}"
    exit 1
}

backup() {
    if [ -e "$1" ] || [ -d "$1" ]; then
        warn_msg "Creating backup $1 -> $1.bak"
        cp -r "$1" "${1}.bak"
        rm -rf "$1"
    fi
}

backup "$BASH_PROMPT"

install_deps() {
    warn_msg "Installing dependencies"

    package_manager=$(command -v pacman || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" -S --needed --noconfirm bash bash-completion tar bat tree unzip fontconfig git
        return 0
    fi

    package_manager=$(command -v apk || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" add bash bash-completion tar bat tree unzip fontconfig git
        return 0
    fi

    package_manager=$(command -v apt-get || command -v dnf || command -v zypper || true)
    if [ -n "$package_manager" ]; then
        "$ESCALATION_TOOL" "$package_manager" install -y bash bash-completion tar bat tree unzip fontconfig git
        return 0
    fi

    return 1
}

if ! install_deps; then
    error_msg "Unsupported package manager"
fi

success_msg "Successfully installed dependencies"

warn_msg "Cloning https://github.com/jeevithakannan2/bash-prompt.git into $BASH_PROMPT"
git clone https://github.com/jeevithakannan2/bash-prompt.git "$BASH_PROMPT"

backup "$BASHRC"
backup "$STARSHIP_CONFIG"

warn_msg "Creating symlinks"
ln -sf "$BASH_PROMPT/.bashrc" "$BASHRC" || error_msg "Failed to link $BASHRC"
ln -sf "$BASH_PROMPT/starship.toml" "$STARSHIP_CONFIG" || error_msg "Failed to link $STARSHIP_CONFIG"

success_msg "Setup completed"
