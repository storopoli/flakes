{ lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  nix.gc.dates = "weekly";

  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  # Enable AMD/Intel microcode
  hardware.enableRedistributableFirmware = true;

  # Fix WiFi speeds
  hardware.wirelessRegulatoryDatabase = true;

  boot = {
    supportedFilesystems = [ "ntfs" "bcachefs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 20;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };

    # Fix WiFi speeds
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="US"
    '';

    blacklistedKernelModules = [
      # Bluetooth disable
      # "btusb"
      # "bnep"
      # "bluetooth"
      "hid_sensor_hub" # give me back by brightness keys
    ];

    consoleLogLevel = 0;

    initrd = {
      luks.devices."encryptedroot".device =
        "/dev/mapper/crypted";

      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];

      verbose = false;
    };
  };

  services = {

    dbus.enable = true;

    locate = {
      enable = true;
      prunePaths = [ "/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" ];
      interval = "hourly";
      package = pkgs.mlocate;
      localuser = null;
    };

    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };

    auto-cpufreq.enable = true;

    thermald.enable = true;
  };

  zramSwap.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;
}
