{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "-c"
          #"zellij a -c main options --default-shell fish"
          "tmux attach -t base || tmux new -s base"
        ];
      };
      window = {
        startup_mode = "Windowed";
        decorations = "Buttonless";
        decorations_theme_variant = "Dark";
        dimensions = {
          columns = 0;
          lines = 0;
        };
        opacity = 0.98;
        option_as_alt = "Both";
        padding = {
          x = 10;
          y = 10;
        };
      };
      font = {
        normal = {
          family = "Hack Nerd Font Propo";
        };
        size = 12.0;
      };
      # URL highlighting
      hints = {
        enabled = [
          {
            regex = ''(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:|www)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`]+'';
            command = "open";
            post_processing = true;
            mouse = {
              enabled = true;
              mods = "Command";
            };
            binding = {
              key = "U";
              mods = "Command|Shift";
            };
          }
        ];
      };
      # catppuccin mocha theme
      colors = {
        primary = {
          background = "#1E1E2E"; # base
          foreground = "#CDD6F4"; # text
          dim_foreground = "#CDD6F4"; # text
          bright_foreground = "#CDD6F4"; # text
        };

        cursor = {
          text = "#1E1E2E"; # base
          cursor = "#F5E0DC"; # rosewater
        };

        vi_mode_cursor = {
          text = "#1E1E2E"; # base
          cursor = "#B4BEFE"; # lavender
        };

        search = {
          matches = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
          focused_match = {
            foreground = "#1E1E2E"; # base
            background = "#A6E3A1"; # green
          };
        };

        footer_bar = {
          foreground = "#1E1E2E"; # base
          background = "#A6ADC8"; # subtext0
        };

        hints = {
          start = {
            foreground = "#1E1E2E"; # base
            background = "#F9E2AF"; # yellow
          };
          end = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
        };

        selection = {
          text = "#1E1E2E"; # base
          background = "#F5E0DC"; # rosewater
        };

        normal = {
          black = "#45475A"; # surface1
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#BAC2DE"; # subtext1
        };

        bright = {
          black = "#585B70"; # surface2
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#A6ADC8"; # subtext0
        };

        dim = {
          black = "#45475A"; # surface1
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#BAC2DE"; # subtext1
        };

        indexed_colors = [
          { index = 16; color = "#FAB387"; }
          { index = 17; color = "#F5E0DC"; }
        ];
      };
      live_config_reload = true;
    };
  };
}
