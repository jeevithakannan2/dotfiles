if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL code
    set -x LS_COLORS $(vivid generate catppuccin-mocha)
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
    set -gx XDG_CACHE_HOME "$HOME/.cache"

    fish_add_path ~/.local/bin

    if grep arch /etc/os-release
        fish_add_path /usr/lib/jvm/default/bin
    end
end
