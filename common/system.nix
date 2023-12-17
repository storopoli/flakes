{ config, lib, pkgs, ... }:

{
  time.timeZone = "America/Sao_Paulo";

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = [ "https://cache.nixos.org/" ];
      auto-optimise-store = true; # Optimise syslinks
    };

    package = pkgs.nixUnstable;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
}
