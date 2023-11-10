{ config, pkgs, lib, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Jose Storopoli";
      userEmail = "jose@storopoli.io";
      signing = {
        key = "0x01BE853A206518CC!";
        signByDefault = true;
      };
      ignores = [
        # Vim/Emacs
        "*~"
        ".*.swp"

        # Mac
        ".DS_Store"
        ".fseventsd"
        ".Spotlight-V100"
        ".TemporaryItems"
        ".Trashes"

        # Helix
        ".helix/"

        # VSCode Workspace Folder
        ".vscode/"

        # Rust
        "debug/"
        "target/"

        # Python
        "*.pyc"
        "*.egg"
        "*.out"
        "venv/"
        "**/**/__pycache__/"

        # Nix
        "result"
        "result-*"

        # direnv
        ".direnv"
        ".envrc"

        # codespell
        ".codespellrc"

        # NodeJS/Web dev
        ".env/"
        "node_modules"
        ".sass-cache"
      ];
      aliases = {
        acp = ''
          !f() { git add . && git commit -m "$@" && git push origin HEAD; }; f'';
        a = "add";
        br = "branch";
        bl = "branch -l";
        c = "commit";
        co = "checkout";
        d = "diff";
        f = "push --force-with-lease";
        g = "grep";
        m = "merge";
        p = "pull";
        pu = "push";
        rv = "revert";
        s = "status";
        st = "status";
        lg =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        last = "log -1 HEAD";
        w = "whatchanged";
        # https://stackoverflow.com/a/11688523/472927
        ss = "!f() { git stash show stash^{/$*} -p; }; f";
        sa = "!f() { git stash apply stash^{/$*}; }; f";
        sl = "stash list";
        tag = "tag -s";
        # https://docs.gitignore.io/install/command-line
        ig =
          "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      };
      extraConfig = {
        init.defaultBranch = "main";
        tag = {
          gpgsign = true;
          forceSignAnnotated = true;
        };
        format.signOff = "yes";
        color.ui = true;
        core = {
          autocrlf = "input";
          safecrlf = true;
        };
        pull.ff = "only";
        push = {
          default = "simple";
          autoSetupRemote = true;
          useForceIfIncludes = true;
        };
        help.autocorrect = "1";
        diff = {
          algorithm = "patience";
          compactionHeuristic = true;
          colorMoved = "default";
        };
        commit = { gpgsign = true; };
        merge.conflictstyle = "diff3";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          light = false;
        };
      };
    };
  };
}
