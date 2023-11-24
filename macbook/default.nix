{ config, pkgs, lib, ... }:

{
  imports = [
    ./agenix.nix
    ./brew.nix
    ./fonts.nix
    ./packages.nix
  ];

  users.users.user = {
    # MacOS User
    home = "/Users/user";
    shell = pkgs.fish; # Default Shell
  };

  networking = {
    computerName = "macbook";
    hostName = "macbook";
    localHostName = "macbook";
  };

  environment.variables.LANG = "en_US.UTF-8";
  environment.etc."hosts" = {
    copy = true;
    text = builtins.readFile (builtins.fetchurl {
      url = "https://github.com/StevenBlack/hosts/raw/3.14.28/alternates/fakenews/hosts";
      sha256 = "19268k1k459dr0zp5xmb6p9sg3ail330f22j9hk3c5539ri9mzs2";
    });
  };

  services = {
    nix-daemon.enable = true; # Auto-Upgrade Daemon
  };

  nix = {
    package = pkgs.nix;
    settings = { trusted-users = [ "root" "user" ]; };
    gc = {
      # Garbage Collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/Sao_Paulo";

  system = import ./system.nix { inherit config pkgs lib; };
}
