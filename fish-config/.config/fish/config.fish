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

    # Set the java home variable if java is installed
    if command -q java
        set -gx JAVA_HOME $(dirname $(command -v java))

        # If arch then add the jvm bin to path 
        # Because keytool, jlink are not available in path by default
        if grep -q arch /etc/os-release
            fish_add_path /usr/lib/jvm/default/bin
        end
    end

    if command -q npm || command -q yarn
        set -gx npm_config_prefix "$HOME/.local"
    end
end
