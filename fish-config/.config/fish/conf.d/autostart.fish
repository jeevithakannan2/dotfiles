if status is-interactive
    if type -q crabfetch
        command crabfetch
    else if type -q fastfetch
        command fastfetch
    end
    starship init fish | source
    zoxide init fish | source
    set -x LS_COLORS $(vivid generate catppuccin-mocha)
end
