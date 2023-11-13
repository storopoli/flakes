{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./alacritty.nix
    ./cli
    ./helix
    ./karabiner
    ./nvim
    ./shell
  ];
}
