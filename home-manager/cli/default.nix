{ config, pkgs, lib, ... }:

{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./cmus.nix
    ./direnv.nix
    ./fzf.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zoxide.nix
  ];
}
