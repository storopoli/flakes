{ pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;
      historyLimit = 100000;
      mouse = true;
      keyMode = "vi";
      escapeTime = 5;
      baseIndex = 1;
      shortcut = "a";
      terminal = "xterm-256color";
      plugins = with pkgs.tmuxPlugins; [
        {
          # https://github.com/catppuccin/tmux
          # Soothing pastel theme for Tmux!
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator " "
            set -g @catppuccin_window_middle_separator " █"
            set -g @catppuccin_window_number_position "right"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules "directory user date_time battery"
            set -g @catppuccin_status_left_separator  " "
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_right_separator_inverse "no"

            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_window_status_icon_enable "yes"
            set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
            set -g @catppuccin_directory_text "#{pane_current_path}"
          '';
        }
        {
          # https://github.com/tmux-plugins/tmux-battery
          # Plug and play battery percentage and icon indicator for Tmux.
          plugin = battery;
        }
        {
          # https://github.com/tmux-plugins/tmux-yank
          # Tmux plugin for copying to system clipboard.
          plugin = yank;
        }
        {
          # https://github.com/tmux-plugins/tmux-resurrect
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on' 
            set -g @resurrect-processes ':all:'
          '';
        }
        {
          # https://github.com/tmux-plugins/tmux-continuum
          # Continuous saving of tmux environment.
          # Automatic restore when tmux is started.
          # Automatic tmux start when computer is turned on.
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-save-interval '120'
            set -g @continuum-restore 'on'
          '';
        }
        {
          # https://github.com/tmux-plugins/tmux-pain-control
          # standard pane key-bindings for tmux
          plugin = pain-control;
          extraConfig = ''
            # Focus events enabled for terminals that support them
            set -g focus-events on

            # Super useful when using "grouped sessions" and multi-monitor setup
            setw -g aggressive-resize on
          '';
        }
      ];
      extraConfig = ''
        # Enables italics in tmux
        set -ga terminal-overrides ",xterm-256color*:Tc"

        # Enable yazi image preview
        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM
      '';
    };
  };
  home = { packages = with pkgs; [ ueberzugpp ]; };
}
