function ssh-auth -d "Ensure SSH agent is running and has key added"
    if test -z "$SSH_AUTH_SOCK"
        eval (ssh-agent -c) >/dev/null
        ssh-add ~/.ssh/id_rsa
    end
end
