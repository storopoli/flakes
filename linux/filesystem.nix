{ ... }:

{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=24G" "mode=755" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/31454764-f5c6-45c7-9f79-036f83405591";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5835-50BF";
    fsType = "vfat";
  };

  fileSystems."/etc/nixos" = {
    device = "/nix/persist/etc/nixos";
    fsType = "none";
    options = [ "bind" ];
  };

  swapDevices = [ ];
}
