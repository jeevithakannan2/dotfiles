function glc -d "View the latest git tag and the commits done after the tag"
    if git symbolic-ref --short HEAD &>/dev/null
        set -l tag (git describe --tags --abbrev=0)
        command git log $tag..HEAD
        builtin printf "%s\n" (set_color yellow)"Latest tag -> $tag"(set_color normal)
    else
        builtin printf "%s\n" (set_color red)"Not a git repository"(set_color normal)
    end
end
