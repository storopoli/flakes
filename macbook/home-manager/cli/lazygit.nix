{ config, pkgs, lib, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      # cattpuccin_mocha blue accent
      gui.theme = {
        activeBorderColor = [ "#89b4fa" "bold" ];
        inactiveBorderColor = [ "#a6adc8" ];
        optionsTextColor = [ "#89b4fa" ];
        selectedLineBgColor = [ "#313244" ];
        selectedRangeBgColor = [ "#313244" ];
        cherryPiCommitBgColor = [ "#45475a" ];
        cherryPickedCommitFgColor = [ "#89b4fa" ];
        unstagedChansColor = [ "#f38ba8" ];
        defaultFgColor = [ "#cdd6f4" ];
        searchingActiveBorderColor = [ "#f9e2af" ];
      };
    };
  };
}
