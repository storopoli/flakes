{ ... }:

{
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
      "/etc/secureboot"
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/power-profiles-daemon"
      "/var/lib/systemd/coredump"
      "/var/lib/upower"
    ];

    files = [
      "/etc/machine-id"
      "/etc/hdd_luks.key"
      "/var/lib/NetworkManager/NetworkManager.state"
      "/var/lib/NetworkManager/secret_key"
      "/var/lib/NetworkManager/seen-bssids"
      "/var/lib/NetworkManager/timestamps"
    ];

    users.user = {
      directories = [
        ".cache" # TODO: specify specific dirs
        ".config" # TODO: specify specific dirs
        ".local" # TODO: specify specific dirs
        ".cargo/registry"
        ".cargo/bin"
        ".cargo/git"
        ".npm-global"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        #".mozilla"
        ".sparrow"
        "git"
        "dev"
        "music"
        "videos"
      ];

      files = [
        ".config/ncspot/userstate.cbor"
      ];
    };
  };
}
