{ ... }:

{
  imports = [
    # linux home-manager configs
    ./chromium.nix
    ./gpg.nix
    ./hyprland
    ./foot.nix
    ./firefox.nix
    ./mpv
    ./rnnoise.nix
    ./zathura.nix
  ];
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };
  programs.home-manager.enable = true;
}
