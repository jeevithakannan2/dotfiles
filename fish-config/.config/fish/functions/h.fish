function h -w history -d "Search Fish history with timestamps"
    builtin history --show-time --contains $argv
end
