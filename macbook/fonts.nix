{ config, pkgs, lib, ... }:

{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      twemoji-color-font
      (nerdfonts.override {
        fonts = [
          "Hack"
        ];
      })
    ];
  };
}
