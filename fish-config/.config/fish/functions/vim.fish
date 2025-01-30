function vim -w $EDITOR
    if type -q $EDITOR
        command $EDITOR $argv
    else
        vim $argv
    end
end
