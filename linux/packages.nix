{ pkgs, ... }:

{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    systemPackages = with pkgs; [
      # linux specific packages
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
}
