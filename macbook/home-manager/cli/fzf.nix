{ config, pkgs, lib, ... }:

{
  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
      tmux.enableShellIntegration = true;
    };
  };
}
