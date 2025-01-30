function reload -d 'Reload Fish configuration'
    source ~/.config/fish/config.fish
    echo (set_color green) "Fish config reloaded!" (set_color normal)
end
