{ ... }:

{
  imports = [
    # linux home-manager configs
    ./gpg.nix
    ./hyprland
    ./foot.nix
    ./mpv
    ./rnnoise.nix
    ./zathura.nix
    ./mold.nix
  ];
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };
  programs.home-manager.enable = true;
}
