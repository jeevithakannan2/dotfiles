#!/bin/env bash

cd "$DOTFILES" || exit 1

if ! command -v paru >/dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || exit 1
    makepkg -si --noconfirm
fi

paru -S --needed --noconfirm fish eza bat ripgrep starship fastfetch zoxide vivid pkgfile trash-cli

"$ESCALATION_TOOL" pkgfile --update

cd "$DOTFILES" || exit 1

stow_link fish-config
fish -c "fish_config theme save mocha"
