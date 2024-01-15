{ config, pkgs, lib, ... }:

{
  programs = {
    helix = {
      enable = true;

      defaultEditor = true;

      extraPackages = with pkgs; [
        # LSPs
        gopls
        ltex-ls
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
        # htmx-lsp #FIXME: broken in darwin-aarch64

        # tree-sitter
        tree-sitter

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
            A-j = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "add_newline_below" "move_line_down" "replace_with_yanked" ];
            A-k = [ "ensure_selections_forward" "extend_to_line_bounds" "extend_char_right" "extend_char_left" "delete_selection" "move_line_up" "add_newline_above" "move_line_up" "replace_with_yanked" ];

            space = {
              w = ":write";
              q = ":quit";
              Q = ":quit-all!";
            };
          };
        };
      };

      languages = {
        language-server = {
          "rust-analyzer".config = {
            check = {
              command = "clippy";
            };
            cargo = {
              features = "all";
            };
          };

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

          "ruff-lsp" = {
            command = "ruff-lsp";
          };

          "ltex-ls".config.ltex = {
            enabled = [ "bibtex" "gitcommit" "context" "context.tex" "html" "latex" "markdown" "pandoc" "typst" "org" "restructuredtext" "rsweave" ];
            language = "en-US";
            disabledRules = { "en-US" = [ "PROFANITY" ]; };
            dictionary = { "en-US" = [ "builtin" ]; };
          };

          "texlab".config.texlab.build = {
            onSave = true;
            executable = "tectonic";
            args = [ "-X" "build" "--keep-logs" "--keep-intermediates" ];
          };

          "typst-lsp" = {
            command = "typst-lsp";
          };

          "htmx-lsp" = {
            command = "htmx-lsp";
          };
        };

        language = [
          {
            name = "rust";
            language-servers = [ "rust-analyzer" ];
          }
          {
            name = "python";
            language-servers = [ "pyright" "ruff-lsp" ];
            formatter = {
              command = "black";
              args = [ "--quiet" "-" ];
            };
            auto-format = true;
          }
          {
            name = "toml";
            language-servers = [ "taplo" ];
            formatter = {
              command = "taplo";
              args = [ "fmt" "-" ];
            };
            auto-format = true;
          }
          {
            name = "yaml";
            language-servers = [ "yaml-language-server" ];
          }
          {
            name = "nix";
            language-servers = [ "nil" ];
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
            language-servers = [ "marksman" "ltex-ls" ];
            formatter = {
              command = "dprint";
              args = [ "fmt" "--stdin" "md" ];
            };
            auto-format = true;
          }
          {
            name = "html";
            language-servers = [ "vscode-html-language-server" "htmx-lsp" ];
            auto-format = true;
          }
          {
            name = "latex";
            auto-format = false;
            language-servers = [ "texlab" "ltex-ls" ];
          }
          {
            # FIXME: in the next helix release typst will be included
            name = "typst";
            scope = "source.typst";
            language-servers = [ "typst-lsp" "ltex-ls" ];
            injection-regex = "typst";
            file-types = [ "typ" "typst" ];
            comment-token = "//";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "`" = "`";
              "$" = "$";
            };
            roots = [ "typst.toml" ];
            auto-format = true;
            formatter = {
              command = "typst-fmt";
              args = [ "/dev/stdin" "-o" "/dev/stdout" ];
            };
          }
        ];

        grammar = [
          {
            name = "typst";
            source = {
              git = "https://github.com/uben0/tree-sitter-typst";
              rev = "e35aa22395fdde82bbc4b5700c324ce346dfc9e5";
            };
          }
        ];

      };
    };
  };
}
