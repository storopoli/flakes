{ ... }:

{
  imports = [
    # linux home-manager configs
    ./gpg.nix
    ./hyprland
  ];
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };
  programs.home-manager.enable = true;
}
