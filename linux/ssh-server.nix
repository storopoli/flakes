{ config, lib, pkgs, ... }:

{

  # Enable SSH server with custom hardened configs
  services.openssh = {
    enable = true;

    settings = {
      # Modern ciphers/MACs
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];

      # require public key authentication for better security
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Only for the user `user`
      AllowUsers = [ "user" ];

      LogLevel = "INFO";
    };
  };

  # Authorized Keys
  users.users."user".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKU4O0J7gdU1+0/IoVZUtajfmWGGNmA3TFXTsbnQfpwt openpgp:0xC116F831"
  ];

  # Mosh
  programs.mosh.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      # Open port 22 in Firewall
      22
    ];

    allowedUDPPortRanges = [
      # Open port 60000-61000 for Mosh
      { from = 60000; to = 61000; }
    ];
  };
}
