{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # linux specific packages
    libnotify
    wl-clipboard
    wlr-randr
    wayland
    wayland-scanner
    wayland-utils
    egl-wayland
    wayland-protocols
    xorg.xeyes
    glfw-wayland
    xwayland
    qt6.qtwayland
    cinnamon.nemo
    networkmanagerapplet
    wev
    wf-recorder
    alsa-lib
    alsa-utils
    flac
    pulsemixer
    linux-firmware
    polkit_gnome
    sshpass
    lxappearance
    imagemagick
    sway-contrib.grimshot
    grim
    brightnessctl
  ];

  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "caps:escape";
    autoRepeatDelay = 200;
    autoRepeatInterval = 30;
  };
  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "user";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    tor.client.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              # Maps capslock to escape when pressed and control when held
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };
  };

  security.rtkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      user ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };
}
