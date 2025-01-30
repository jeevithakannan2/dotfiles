function grep -w grep
    if type -q rg
        command rg --color auto $argv
    else
        command grep --color auto $argv
    end
end
