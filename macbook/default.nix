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
      url = "https://github.com/StevenBlack/hosts/raw/3.14.25/alternates/fakenews/hosts";
      sha256 = "1nbqfxbfjshf32g4w17yxp0jbqvgifrqiidwkpbyyaq5c6q8jcac";
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
