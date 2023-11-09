{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # VI key bindings
      set fish_key_bindings fish_vi_key_bindings

      # SSH GPG auth
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent

      # fish path stuff
      fish_add_path /run/current-system/sw/bin
      fish_add_path /Users/user/.nix-profile/bin
      fish_add_path /etc/profiles/per-user/user/bin
      fish_add_path /opt/homebrew/bin
      fish_add_path /Users/user/.cargo/bin

      # catppuccin fzf
      set -Ux FZF_DEFAULT_OPTS "\
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      # name: 'Catppuccin mocha'
      # url: 'https://github.com/catppuccin/fish'
      # preferred_background: 1e1e2e
      set fish_color_normal cdd6f4
      set fish_color_command 89b4fa
      set fish_color_param f2cdcd
      set fish_color_keyword f38ba8
      set fish_color_quote a6e3a1
      set fish_color_redirection f5c2e7
      set fish_color_end fab387
      set fish_color_comment 7f849c
      set fish_color_error f38ba8
      set fish_color_gray 6c7086
      set fish_color_selection --background=313244
      set fish_color_search_match --background=313244
      set fish_color_option a6e3a1
      set fish_color_operator f5c2e7
      set fish_color_escape eba0ac
      set fish_color_autosuggestion 6c7086
      set fish_color_cancel f38ba8
      set fish_color_cwd f9e2af
      set fish_color_user 94e2d5
      set fish_color_host 89b4fa
      set fish_color_host_remote a6e3a1
      set fish_color_status f38ba8
      set fish_pager_color_progress 6c7086
      set fish_pager_color_prefix f5c2e7
      set fish_pager_color_completion cdd6f4
      set fish_pager_color_description 6c7086
    '';
    shellAliases = {
      devshell = "nix flake new -t 'github:numtide/devshell' .";
      e = "nvim";
      g = "git";
      lg = "lazygit";
      testtor = "curl -x socks5h://localhost:9050 -s https://check.torproject.org/api/ip";
      top = "btm";
      vi = "nvim";
      vim = "nvim";
      yt = "yt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all";
      yta = "yt -x -f bestaudio/best --format mp4 --audio-format opus --restrict-filenames --sponsorblock-remove all";
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
          hash = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
        };
      }
    ];
  };

  xdg.configFile = {
    "fish/functions/flakify.fish".source = ./functions/flakify.fish;
    "fish/functions/find_rust.fish".source = ./functions/find_rust.fish;
    "fish/functions/man.fish".source = ./functions/man.fish;
    "fish/functions/nixify.fish".source = ./functions/nixify.fish;
    "fish/functions/nix_update.fish".source = ./functions/nix_update.fish;
    "fish/functions/rename_metadata.fish".source = ./functions/rename_metadata.fish;
    "fish/functions/storopoli.fish".source = ./functions/storopoli.fish;
    "fish/functions/ytp.fish".source = ./functions/ytp.fish;
  };
}
