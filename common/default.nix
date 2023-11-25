{ pkgs, ... }:

{
  imports = [
    ./system.nix
    ./packages.nix
    ./shell.nix
    ./age.nix
  ];
  programs.fish.enable = true;
  networking.hostName = "laptop";
  users.users.user.shell = pkgs.fish;
  nix.settings.trusted-users = [ "root" "user" ];
}
