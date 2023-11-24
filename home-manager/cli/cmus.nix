{ config, pkgs, lib, ... }:

{
  home.file.".config/cmus/rc".text = ''
    bind -f common ^T push run opustags -s FIELD=VALUE -i {}
  '';
  home.file.".config/cmus/catppuccin.theme".source = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/Sekki21956/cmus/main/catppuccin.theme";
    sha256 =
      "2a006b0099662be9c8a267529872a1f32fe8ce269d421fb08758f5a68e989d5c";
  };
}
