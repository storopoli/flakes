{ ... }:

{
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard"
      "/var/log"
      "/var/lib"
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
