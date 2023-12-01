{ config, ... }:

{
  imports = [
    ./system.nix
    ./filesystem.nix
    ./networking.nix
    ./packages.nix
    ./bluetooth.nix
    ./fonts.nix
    ./wayland.nix
    ./hyprland.nix
    ./impermanence.nix
  ];
  users = {
    mutableUsers = false;
    users = {
      root.hashedPasswordFile = config.age.secrets.root.path;
      user = {
        hashedPasswordFile = config.age.secrets.password.path;
        isNormalUser = true;
        extraGroups =
          [ "wheel" "docker" "libvirtd" "video" "audio" "networkmanager" ];
      };
    };
  };
}
