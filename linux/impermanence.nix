{ ... }:

{
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard"
      "/etc/mullvad-vpn"
      "/var/cache/mullvad-vpn"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/power-profiles-daemon"
      "/var/lib/systemd/coredump"
      "/var/lib/upower"
    ];

    files = [
      "/etc/machine-id"
      "/var/lib/NetworkManager/secret_key"
      "/var/lib/NetworkManager/seen-bssids"
      "/var/lib/NetworkManager/timestamps"
    ];

    users.user = {
      directories = [
        ".cache"
        ".config"
        ".local"
        ".cargo"
        ".julia"
        ".npm-global"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".mozilla"
        ".sparrow"
        "git"
        "dev"
        "music"
        "videos"
      ];

      files = [
        # put files here
      ];
    };
  };
}
