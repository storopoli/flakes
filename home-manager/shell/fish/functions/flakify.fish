function flakify
    if not test -e ./flake.nix
        nix flake new -t github:nix-community/nix-direnv .
    else if not test -e ./.envrc
        printf "use flake\n" >.envrc
        direnv allow
    end
    $EDITOR flake.nix
end
