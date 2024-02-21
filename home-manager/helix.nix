{ config, pkgs, lib, ... }:

{
  programs = {
    helix = {
      enable = true;

      defaultEditor = true;

      extraPackages = with pkgs; [
        # LSPs
        marksman
        nil
        nodePackages_latest.bash-language-server
        nodePackages_latest.vscode-langservers-extracted
        nodePackages_latest.pyright
        ruff-lsp
        rust-analyzer
        taplo
        typst-lsp
        yaml-language-server

        # debugger
        lldb # provides lldb-vscode

        # formatter
        black
        dprint
        nixpkgs-fmt
        typstfmt
      ];

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          line-number = "relative";
          mouse = true;
          scrolloff = 8;
          cursorline = true;
          rulers = [ 80 ];
          true-color = true;
          color-modes = true;
          completion-trigger-len = 1;
          idle-timeout = 50;
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
            right = [ "workspace-diagnostics" "selections" "position-percentage" "position" "file-encoding" "file-type" ];
          };
          indent-guides = {
            render = true;
            character = "╎";
          };
          whitespace = {
            render = {
              tab = "all";
            };
            character = {
              tab = "→";
              tabpad = "·";
            };
          };
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };

        keys = {
          normal = {
            esc = [ "collapse_selection" "keep_primary_selection" ];
            A-j = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "add_newline_below" "move_line_down" "replace_with_yanked" ];
            A-k = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "move_line_up" "add_newline_above" "move_line_up" "replace_with_yanked" ];
            A-x = "extend_to_line_bounds";
            X = [ "extend_line_up" "extend_to_line_bounds" ];

            space = {
              w = ":write";
              q = ":quit";
              Q = ":quit-all!";
            };
          };
          select = {
            A-x = "extend_to_line_bounds";
            X = [ "extend_line_up" "extend_to_line_bounds" ];
          };
        };
      };

      languages = {
        language-server = {

          "rust-analyzer".config = {
            check.command = "clippy";
            cargo.features = "all";
            inlayHints.discriminantHints.enable = "always";
          };

          "ruff-lsp".command = "ruff-lsp";

          "yaml-language-server".config = {
            yaml = {
              format = { enable = true; };
              validation = true;
              schemas = {
                "kubernetes" = "*.yaml";
                "https=//raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "docker-compose.yaml";
                "https=//json.schemastore.org/github-workflow.json" = ".github/workflows/*.yaml";
                "https=//json.schemastore.org/github-action.json" = ".github/actions/*/action.yaml";
              };
            };
          };

          "typst-lsp".command = "typst-lsp";

          "gpt" = {
            command = "helix-gpt";
            args = [
              "--handler"
              "copilot"
            ];
          };

        };

        language = [
          {
            name = "rust";
            language-servers = [ "rust-analyzer" "gpt" ];
          }
          {
            name = "python";
            language-servers = [ "pyright" "ruff-lsp" "gpt" ];
            formatter = {
              command = "black";
              args = [ "--quiet" "-" ];
            };
            auto-format = true;
          }
          {
            name = "toml";
            language-servers = [ "taplo" "gpt" ];
            formatter = {
              command = "taplo";
              args = [ "fmt" "-" ];
            };
            auto-format = true;
          }
          {
            name = "yaml";
            language-servers = [ "yaml-language-server" "gpt" ];
          }
          {
            name = "nix";
            language-servers = [ "nil" "gpt" ];
            formatter = {
              command = "nixpkgs-fmt";
            };
            auto-format = true;
          }
          {
            name = "fish";
            formatter = {
              command = "fish_indent";
            };
            auto-format = true;
          }
          {
            name = "markdown";
            language-servers = [ "marksman" "gpt" ];
            formatter = {
              command = "dprint";
              args = [ "fmt" "--stdin" "md" ];
            };
            auto-format = true;
          }
        ];
      };
    };
  };
}
