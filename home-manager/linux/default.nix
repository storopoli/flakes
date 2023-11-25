{ ... }:

{
  imports = [
    # linux home-manager configs
    ./gpg.nix
    ./hyprland
    ./foot.nix
    ./firefox.nix
    ./zathura.nix
  ];
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };
  programs.home-manager.enable = true;
}
