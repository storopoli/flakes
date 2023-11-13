{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./shell
    ./cli
    ./alacritty.nix
    ./helix
    ./karabiner
    ./shell
  ];
}
