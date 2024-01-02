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
      auto-cpufreq
    ];
  };

  # linux specific user packager
  users.users.user.packages = (with pkgs; [
    vscodium
    # opsec
    keepassxc
    tor-browser-bundle-bin
    signal-desktop

    # bitcoin
    sparrow
    bisq-desktop

    # media
    mediainfo
    exiftool
    qpwgraph
    playerctl
    mat2
    transmission_4
    obs-studio
  ]) ++ (with config.nur.repos;
    [
      # nur packages
      # https://nur.nix-community.org/
    ]);

}
