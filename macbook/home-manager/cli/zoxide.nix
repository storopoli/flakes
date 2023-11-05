{ config, pkgs, lib, ... }:

{
  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
