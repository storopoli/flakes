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

      # Secure Boot
      sbctl
    ];
  };

  # linux specific user packager
  users.users.user.packages = (with pkgs; [
    # opsec
    #keepassxc # firejailed in hardening.nix
    #tor-browser-bundle-bin # firejailed in hardening.nix
    #signal-desktop # firejailed in hardening.nix

    # bitcoin
    sparrow
    bisq-desktop

    # media
    mediainfo
    exiftool
    qpwgraph
    playerctl
    mat2
    #transmission_4 # firejailed in hardening.nix
    obs-studio
  ]);

}
