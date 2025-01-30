function cd -w z -d 'zoxide to the directory and run ls'
    if test -z "$argv[1]"
        cd ~
    else
        z "$argv[1]" && ls
    end
end
