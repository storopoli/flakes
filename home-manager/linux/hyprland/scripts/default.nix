{ config, lib, pkgs, ... }:

let
  keybind = pkgs.writeShellScriptBin "keybind" (builtins.readFile ./keybind.sh);
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" (builtins.readFile ./wallpaper_random.sh);
  myswaylock = pkgs.writeShellScriptBin "myswaylock" (builtins.readFile ./myswaylock.sh);
  dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" (builtins.readFile ./dynamic_wallpaper.sh);
  default_wall = pkgs.writeShellScriptBin "default_wall" (builtins.readFile ./default_wall.sh);
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" (builtins.readFile ./launch_waybar.sh);
in
{
  home.packages = [
    keybind
    wallpaper_random
    myswaylock
    dynamic_wallpaper
    default_wall
    launch_waybar
  ];
}
