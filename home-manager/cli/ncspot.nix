{ pkgs, config, lib, ... }:

{
  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
    };
  };
}
