if status is-interactive
    starship init fish | source
    zoxide init fish | source
    set -x LS_COLORS $(vivid generate catppuccin-mocha)
end
