{ ... }:

{
  imports = [
    ./disko.nix
  ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=64G" "mode=755" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/crypted";
    fsType = "bcachefs";
    options = [ "defaults" "compression=zstd" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-nvme0n1-ESP";
    fsType = "vfat";
    options = [ "defaults" ];
  };

  fileSystems."/etc/nixos" = {
    device = "/nix/persist/etc/nixos";
    fsType = "none";
    options = [ "bind" ];
  };

  # HDD 4TB
  fileSystems."/hdd" = {
    device = "/dev/mapper/hdd";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };

  swapDevices = [ ];
}
