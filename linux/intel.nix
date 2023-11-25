{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "quiet"
      "splash"

      # framework specific ones
      # Fixes a regression in s2idle, making it more power efficient than deep sleep
      "acpi_osi=\"!Windows 2020\""
      # For Power consumption
      # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
      "mem_sleep_default=deep"
      # Workaround iGPU hangs
      # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
      "i915.enable_psr=1"
      # better battery life for NVME
      "nvme.noacpi=1"
    ];

    # This enables the brightness and airplane mode keys to work
    # https://community.frame.work/t/12th-gen-not-sending-xf86monbrightnessup-down/20605/11
    blacklistedKernelModules = [ "hid-sensor-hub" ];
  };
  services = {
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        TLP_DEFAULT_MODE = "AC";
        TLP_PERSISTENT_DEFAULT = 0;
        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 2;
        MAX_LOST_WORK_SECS_ON_AC = 15;
        MAX_LOST_WORK_SECS_ON_BAT = 60;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_HWP_ON_AC = "balance_performance";
        CPU_HWP_ON_BAT = "balance_power";
        CPU_MAX_PERF_ON_AC = 100;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
        NMI_WATCHDOG = 0;
        ENERGY_PERF_POLICY_ON_AC = "performance";
        ENERGY_PERF_POLICY_ON_BAT = "powersave";
        DISK_DEVICES = "sda sdb nvme0n1";
        DISK_APM_LEVEL_ON_AC = "254 254";
        DISK_APM_LEVEL_ON_BAT = "128 128";
        SATA_LINKPWR_ON_AC = "max_performance";
        SATA_LINKPWR_ON_BAT = "min_power";
        AHCI_RUNTIME_PM_TIMEOUT = 15;
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersupersave";
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        WOL_DISABLE = "Y";
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1;
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = 1;
        USB_BLACKLIST_BTUSB = 0;
        USB_BLACKLIST_PHONE = 0;
        USB_BLACKLIST_WWAN = 1;
        RESTORE_DEVICE_STATE_ON_STARTUP = 0;
        DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
        DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
        DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
        DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
        DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
      };
    };

    # Custom udev rules
    udev.extraRules = ''
      # Fix headphone noise when on powersave
      # https://community.frame.work/t/headphone-jack-intermittent-noise/5246/55
      SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0xa0e0", ATTR{power/control}="on"
    '';
  };
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
      ];
    };
    pulseaudio.support32Bit = true;

    # Mis-detected by nixos-generate-config
    # https://github.com/NixOS/nixpkgs/issues/171093
    # https://wiki.archlinux.org/title/Framework_Laptop#Changing_the_brightness_of_the_monitor_does_not_work
    acpilight.enable = lib.mkDefault true;
  };
  environment = {
    systemPackages = with pkgs; [ libva libva-utils glxinfo fw-ectool ];
    variables = { LIBVA_DRIVER_NAME = "iHD"; };
  };
}
