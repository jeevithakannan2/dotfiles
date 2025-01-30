function vi -w $EDITOR
    if type -q $EDITOR
        command $EDITOR $argv
    else
        vi $argv
    end
end
