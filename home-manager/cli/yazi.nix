{ config, pkgs, lib, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
}
