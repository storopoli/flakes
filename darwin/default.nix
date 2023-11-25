{ ... }:

{
  imports = [
    ./system.nix
    ./packages.nix
    ./fonts.nix
    ./brew.nix
  ];
  users.users.user.home = "/Users/user";
  networking.computerName = "laptop";
  networking.localHostName = "laptop";
}
