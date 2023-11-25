{ config, lib, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "quiet"
      "splash"

      # framework specific ones
      # https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html#active-mode
      # note: if you're using 6.1, use "passive"
      "amd_pstate=active"
    ];
    # https://git.exozy.me/a/zenpower3
    extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  };
  services = {
    # AMD has better battery life with PPD over TLP:
    # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
    power-profiles-daemon.enable = lib.mkDefault true;
  };
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        amdvlk
      ];
    };
    pulseaudio.support32Bit = true;
  };
  environment = {
    systemPackages = with pkgs; [ glxinfo ];
  };
}
