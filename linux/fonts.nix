{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ twemoji-color-font ];
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      twemoji-color-font
      font-awesome
      (nerdfonts.override {
        fonts = [
          "Hack"
        ];
      })
    ];
  };
}
