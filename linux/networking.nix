{ lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      tor
      torsocks
      wireguard-tools
      openresolv
    ];

    etc = {
      "NetworkManager/conf.d/wifi_rand_mac.conf" = {
        text = ''
          [device-mac-randomization]
          # "yes" is already the default for scanning
          wifi.scan-rand-mac-address=yes

          [connection-mac-randomization]
          # Randomize MAC for every ethernet connection
          #ethernet.cloned-mac-address=random
          # Generate a random MAC ethernet connection
          ethernet.cloned-mac-address=stable
          # Generate a randomized value upon each connection
          #wifi.cloned-mac-address=random
          # Generate a random MAC for each WiFi and associate the two permanently
          wifi.cloned-mac-address=stable
        '';
        mode = "0400";
      };
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

  networking = {
    networkmanager.enable = true;
    wireguard.enable = true;
    stevenblack = {
      enable = true;
      block = [ "fakenews" ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        51413 # transmission
      ];
      allowedUDPPorts = [
        51413 # transmission
      ];
    };
  };

  services = {
    openssh.enable = false;

    tor.enable = true;
  };

  # TODO: wireguard configs with agenix
}
