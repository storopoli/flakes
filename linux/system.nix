{ config, lib, pkgs, modulesPath, ... }:

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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Enable AMD/Intel microcode
  hardware.enableRedistributableFirmware = true;

  # Fix WiFi speeds
  hardware.wirelessRegulatoryDatabase = true;

  # Needed for desktop environments to detect/manage display brightness
  hardware.sensor.iio.enable = lib.mkDefault true;

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
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
      # Fix TRRS headphones missing a mic
      # https://community.frame.work/t/headset-microphone-on-linux/12387/3
      #
      # This is temporary until a kernel patch is submitted
      options snd-hda-intel model=dell-headset-multi
    '';

    blacklistedKernelModules = [
      # Bluetooth
      # "btusb"
      # "bnep"
      # "bluetooth"
      "hid_sensor_hub" # give me back by brightness keys
    ];

    consoleLogLevel = 0;

    initrd = {
      luks.devices."encryptedroot".device =
        "/dev/disk/by-uuid/44795d11-d166-49d7-89e9-62a9945e05f3";

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

    fstrim.enable = true;

    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };

    auto-cpufreq.enable = true;

    thermald.enable = true;

    fprintd.enable = lib.mkDefault true;

    # Custom udev rules
    udev.extraRules = ''
      # Ethernet expansion card support
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
    '';
  };

  zramSwap.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;
}
