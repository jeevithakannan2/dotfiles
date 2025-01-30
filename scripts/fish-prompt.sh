#!/bin/env bash

cd "$DOTFILES" || exit 1
"$ESCALATION_TOOL" pacman -S --needed --noconfirm fish eza bat ripgrep starship fastfetch zoxide vivid

stow_link fish-config
fish -c "fish_config theme save mocha"
