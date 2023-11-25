{ pkgs, ... }:

{
  home = {
    sessionVariables = { GTK_THEME = "Catppuccin-Frappe-Pink"; };
    pointerCursor = {
      package = pkgs.catppuccin-cursors.frappeDark;
      name = "Catppuccin-Frappe-Dark-Cursors";
      size = 16;
      gtk.enable = true;
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Frappe-Standard-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ]; # You can specify multiple accents here to output multiple themes 
        # size = "compact";
        # tweaks = [ "rimless" "black" ]; # You can also specify multiple tweaks here
        variant = "frappe";
      };
    };
    cursorTheme = { name = "Catppuccin-Frappe-Dark"; };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Hack Nerd Font Propo";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}
