{ config, pkgs, lib, ... }:

{
  home.file.".config/ncdu/config".text = ''
    # color scheme intended for dark backgrounds
    --color dark
    # Exclude .git directories
    --exclude .git
  '';
}
