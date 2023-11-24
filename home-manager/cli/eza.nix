{ config, pkgs, lib, ... }:

{
  programs.eza = {
    enable = true;
    enableAliases = true;
  };
}
