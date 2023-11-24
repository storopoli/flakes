{ config, pkgs, lib, ... }:

{
  programs.yt-dlp.enable = true;
  home.file = {
    ".config/yt-dlp/config".text = ''
      --ignore-errors
      # Prefer 1080p or lower resolutions
      -f bestvideo[ext=mp4][width<2000][height<=1200]+bestaudio[ext=m4a]/bestvideo[ext=webm][width<2000][height<=1200]+bestaudio[ext=webm]/bestvideo[width<2000][height<=1200]+bestaudio/best[width<2000][height<=1200]/best
    '';
  };
}
