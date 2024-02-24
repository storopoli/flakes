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

    tor-browser = {
      executable = "${pkgs.tor-browser-bundle-bin}/bin/tor-browser";
      profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
    };

    signal-desktop = {
      executable = "${pkgs.lib.getBin pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
      profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
      extraArgs = [ "--env=GTK_THEME=Adwaita:dark" ];
    };

    keepassxc = {
      executable = "${pkgs.lib.getBin pkgs.keepassxc}/bin/keepassxc";
      profile = "${pkgs.firejail}/etc/firejail/keepassxc.profile";
    };

    mpv = {
      executable = "${pkgs.lib.getBin pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };

    transmission-gtk = {
      executable = "${pkgs.lib.getBin pkgs.transmission_4-gtk}/transmission-gtk";
      profile = "${pkgs.firejail}/transmission-gtk.profile";
    };
  };

  # enable antivirus clamav and
  # keep the signatures' database updated
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
