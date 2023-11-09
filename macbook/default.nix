{ config, pkgs, lib, ... }:

{
  imports = [
    ./fonts.nix
    ./brew.nix
    ./packages.nix
    ./agenix.nix
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
      url = "https://github.com/StevenBlack/hosts/raw/3.14.24/alternates/fakenews/hosts";
      sha256 = "19mx3gn6vssbscm7jijn483hi6ay21w8x3i9wxbiwdlb2rzz85pv";
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
