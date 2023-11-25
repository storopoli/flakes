{ config, pkgs, ... }:

{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    # linux specific system packages
    systemPackages = with pkgs; [
      mlocate
      file
      gnupg
      atool
      unzip
      glib
      killall
      xdg-utils
      pciutils
      socat
      zip
      gnumake
      exfat
      detox
    ];
  };

  nix.package = pkgs.nixVersions.unstable;

  # linux specific user packager
  users.users.user.packages = (with pkgs; [
    keepassxc
    tor-browser-bundle-bin
    signal-desktop
    sparrow
    bisq-desktop
    libreoffice-fresh
    qpwgraph
    playerctl
  ]) ++ (with config.nur.repos;
    [
      # nur packages
      # https://nur.nix-community.org/
    ]);

}
