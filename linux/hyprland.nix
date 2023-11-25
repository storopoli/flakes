{ pkgs, ... }:

{
  programs = {
    dconf.enable = true;
    light.enable = true;
    hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    grimblast
    hyprpicker
    swww
    swaylock-effects
    pamixer
    waybar
  ];

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
