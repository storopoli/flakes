function codespell_ignore
    set word_to_ignore $argv[1]
    if not test -e .codespellrc
        printf "[codespell]\nignore-words = $word_to_ignore" >.codespellrc
    else
        sed -i '' "s/\(ignore-words = .*\)/\1,$word_to_ignore/" .codespellrc
    end
end
