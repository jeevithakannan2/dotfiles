if status is-interactive
    set -x PATH $HOME/.local/bin $PATH
    set -gx EDITOR nvim
    set -gx VISUAL code
    set -x LS_COLORS $(vivid generate catppuccin-mocha)
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
    set -gx XDG_CACHE_HOME "$HOME/.cache"

    if grep -q arch /etc/os-release
        set -x PATH /usr/lib/jvm/default/bin $PATH
    end
end
