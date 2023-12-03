{ ... }:

{
  imports = [
    ./variables.nix
    ./wallpaper.nix
    ./scripts
    ./waybar
    ./gtk.nix
    ./rofi
    ./mako.nix
  ];
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    enableNvidiaPatches = false;
    extraConfig = (builtins.readFile ./hyprland.conf);
  };
}
