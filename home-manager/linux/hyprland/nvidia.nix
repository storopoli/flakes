{ pkgs, ... }:
{
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  #wayland.windowManager.hyprland.enableNvidiaPatches = true; # FIXME: The option `enableNvidiaPatches` has been removed

  home.packages = with pkgs; [
    #nvtopPackages.nvidia #FIXME: this will be the default in 24.05
    nvtop-nvidia
  ];
}
