{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Hack Nerd Font Propo:size=12";
        dpi-aware = "no";
        bold-text-in-bright = "yes";
        initial-window-mode = "maximized";
      };
      key-bindings = {
        search-start = "Control+Shift+f";
        show-urls-launch = "Control+Shift+u";
      };
      colors = {
        alpha = 0.98;
        foreground = "cdd6f4";
        background = "1e1e2e";
        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";
        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";
      };
      csd = { hide-when-maximized = "yes"; };
    };
  };
}
