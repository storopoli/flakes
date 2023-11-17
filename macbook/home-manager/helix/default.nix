{ config, pkgs, lib, ... }:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = false;
      settings = {
        theme = "catppuccin_mocha";

        editor = {
          line-number = "relative";
          mouse = true;
          scrolloff = 8;
          rulers = [ 80 ];
          true-color = true;
          color-modes = true;
          bufferline = "multiple";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          file-picker = {
            hidden = false;
          };
          statusline = {
            left = [ "mode" "spinner" "version-control" ];
            center = [ "file-name" ];
            right = [ "diagnostics" "selections" "position-percentage" "position" "file-encoding" "file-line-ending" "file-type" ];
            separator = "│";
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
          };
          indent-guides = {
            render = true;
          };
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };
        keys = {
          normal = {
            esc = [ "collapse_selection" "keep_primary_selection" ];
            X = [ "extend_line_up" "extend_to_line_bounds" ];
            A-x = "extend_to_line_bounds";
            A-j = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "add_newline_below" "move_line_down" "replace_with_yanked" ];
            A-k = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "move_line_up" "add_newline_above" "move_line_up" "replace_with_yanked" ];
            C-n = [
              "extend_line"
              ":insert-output echo 'FILL_THIS'"
              "extend_line_below"
              ":pipe sgpt --code --no-cache 'Using this comment fill the line having the comment FILL_THIS.'"
            ];

            space = {
              w = ":write";
              q = ":quit";
              Q = ":quit-all!";
              c = [ ":pipe sgpt --code --temperature 0.3 --no-cache 'Replace this code with a better version and complete it.'" ];
              C = [
                ":sh echo working..."
                ":pipe-to cat > /tmp/helix-gpt"
                ":append-output cat /tmp/helix-gpt | sgpt --code --temperature 0.3 --no-cache 'Finish this code. Start typing from where I left.'"
                ":sh echo done!"
              ];
            };
          };
          select = {
            X = [ "extend_line_up" "extend_to_line_bounds" ];
            A-x = "extend_to_line_bounds";
          };
          insert = {
            C-n = [
              "normal_mode"
              "extend_line"
              ":insert-output echo 'FILL_THIS'"
              "extend_line_below"
              ":pipe sgpt --code --no-cache 'Using this comment fill the line having the comment FILL_THIS.'"
            ];
          };
        };
      };
    };
  };
  home = {
    packages = with pkgs; [
      # LSPs
      gopls
      ltex-ls
      lua-language-server
      marksman
      nil
      nodePackages_latest.bash-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.pyright
      ruff
      ruff-lsp
      rust-analyzer
      taplo
      texlab
      typst-lsp
      yaml-language-server

      # tree-sitter
      tree-sitter

      # debugger
      lldb # provides lldb-vscode

      # formatter
      black
      dprint
      nixpkgs-fmt
      stylua

      # chatgpt
      shell_gpt
    ];
    file.".config/helix/languages.toml".source = ./languages.toml;
    file.".local/bin/julia-lsp.jl" = {
      source = ./julia-lsp.jl;
      executable = true;
    };
  };
}
