if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MAKEFLAGS -j$(nproc)
    set -gx LS_COLORS $(vivid generate catppuccin-mocha)
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
    set -gx XDG_CACHE_HOME "$HOME/.cache"

    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.cargo/bin"

    if grep -q arch /etc/os-release
        fish_add_path /usr/lib/jvm/default/bin
    end
end
