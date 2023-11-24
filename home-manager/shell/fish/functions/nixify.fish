function nixify
    if not test -e ./.envrc
        printf "use nix\n" >.envrc
        direnv allow
    end
    if not test -e shell.nix -a ! -e default.nix
        printf 'with import <nixpkgs> {};\n' >>default.nix
        printf 'mkShell {\n' >>default.nix
        printf '  nativeBuildInputs = [\n' >>default.nix
        printf '    bashInteractive\n' >>default.nix
        printf '  ];\n' >>default.nix
        printf '}\n' >>default.nix
    end
    $EDITOR default.nix
end
