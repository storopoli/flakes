{ config, ... }:

{
  imports = [
    ./system.nix
    ./filesystem.nix
    ./networking.nix
    ./packages.nix
    ./bluetooth.nix
    ./amd.nix
    # ./intel.nix
    ./fonts.nix
    ./wayland.nix
    ./hyprland.nix
    ./impermanence.nix
  ];
  users = {
    mutableUsers = false;
    users = {
      # TODO: fix password with agenix
      root.passwordFile = config.age.secrets.root.path;
      user = {
        passwordFile = config.age.secrets.password.path;
        isNormalUser = true;
        extraGroups =
          [ "wheel" "docker" "libvirtd" "video" "audio" "networkmanager" ];
      };
    };
  };
}
