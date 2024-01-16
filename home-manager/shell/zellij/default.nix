{ config, pkgs, lib, ... }:

{
  programs = {
    zellij = {
      enable = true;

      enableFishIntegration = false; # this will launch every time you open fish
    };
  };

  xdg.configFile."zellij/config.kdl".source = ./zellij.kdl;
}
