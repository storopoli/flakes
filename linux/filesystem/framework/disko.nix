{ config, disks ? [ "/dev/nvme0n1" ], ... }:

{
  disko.devices = {
    disk = {
      nvme0n1 = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1GiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                passwordFile = config.age.secrets.luks.path;
                content = {
                  type = "filesystem";
                  format = "bcachefs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  mountpoint = "/nix";
                  mountOptions = [ "compression=zstd" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=16G" # 32GB RAM (leaving 16GB for RAM)
          "mode=755"
        ];
      };
    };
  };
}
