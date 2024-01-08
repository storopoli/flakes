{ pkgs, ... }:

{
  programs.mpv.enable = true;

  home.packages = with pkgs; [ mpvScripts.mpris ];

  home.file = {
    ".config/mpv/mpv.conf".source = ./mpv.conf;

    ".config/mpv/scripts-opts/mpv_thumbnail_script.conf".source =
      ./script-opts/mpv_thumbnail_script.conf;
    ".config/mpv/scripts/mpv_thumbnail_script_client_osc.lua".source =
      builtins.fetchurl {
        url =
          "https://github.com/marzzzello/mpv_thumbnail_script/releases/download/0.5.3/mpv_thumbnail_script_client_osc.lua";
        sha256 =
          "0xhh8xbm5lhb8wx096xs3rijdrkcq0ndm3s64g6m7x5vk182h64c";
      };
    ".config/mpv/scripts/mpv_thumbnail_script_server-1.lua".source =
      builtins.fetchurl {
        url =
          "https://github.com/marzzzello/mpv_thumbnail_script/releases/download/0.5.3/mpv_thumbnail_script_server.lua";
        sha256 =
          "18cnajq6ldz0m0fhgdrhknlljmvy8bbd4dg56vp7fqbk4ax34fcq";
      };
    ".config/mpv/scripts/mpv_thumbnail_script_server-2.lua".source =
      builtins.fetchurl {
        url =
          "https://github.com/marzzzello/mpv_thumbnail_script/releases/download/0.5.3/mpv_thumbnail_script_server.lua";
        sha256 =
          "18cnajq6ldz0m0fhgdrhknlljmvy8bbd4dg56vp7fqbk4ax34fcq";
      };
  };
}
