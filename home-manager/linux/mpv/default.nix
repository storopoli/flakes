{ pkgs, ... }:

{
  programs.mpv.enable = true;

  home.packages = with pkgs; [ mpvScripts.mpris ];

  home.file = {
    ".config/mpv/mpv.conf".source = ./mpv.conf;

    ".config/mpv/scripts/file_browser.lua".source = builtins.fetchurl {
      url =
        "https://github.com/CogentRedTester/mpv-file-browser/raw/3fedbd506dd9ca62c121105ad4d48acdf34bcd53/file-browser.lua";
      sha256 = "0hqlfcdmmsbry41axhyvjjfd4rcavw75f9awirv2ijh8ivvzh5gj";
    };
    ".config/mpv/scripts-opts/file_browser.conf".source =
      builtins.fetchurl {
        url =
          "https://github.com/CogentRedTester/mpv-file-browser/raw/3fedbd506dd9ca62c121105ad4d48acdf34bcd53/file_browser.conf";
        sha256 =
          "1f82zlar3lbwxpjwygml96py91mdyckagc267cpm97nz2a5hrqgl";
      };

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
