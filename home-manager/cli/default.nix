{ config, pkgs, lib, ... }:

{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./fzf.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./ncspot.nix
    ./termusic.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zoxide.nix
  ];
}
