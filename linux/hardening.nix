{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/profiles/hardened.nix>
    ];

  # enable firewall and block all ports
  #networking.firewall.enable = true; # already defined by networking.nix
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # disable coredump that could be exploited later
  # and also slow down the system when something crash
  systemd.coredump.enable = false;

  # required to run chromium
  security.chromiumSuidSandbox.enable = true;

  # enable firejail
  programs.firejail.enable = true;

  # create system-wide executables firefox and chromium
  # that will wrap the real binaries so everything
  # work out of the box.
  programs.firejail.wrappedBinaries = {
    #firefox = {
    #    executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
    #    profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
    #};
    chromium = {
      executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
      profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
    };
  };

  # enable antivirus clamav and
  # keep the signatures' database updated
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
