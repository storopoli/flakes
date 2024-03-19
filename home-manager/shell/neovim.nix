{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #neovix
    lazynvim
  ];

}
