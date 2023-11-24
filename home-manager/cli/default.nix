{ config, pkgs, lib, ... }:

{
  imports = [
    # ./btop.nix
    ./bat.nix
    ./bottom.nix
    ./broot.nix
    ./cmus.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./lazygit.nix
    ./ncdu.nix
    ./ripgrep.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zoxide.nix
  ];
}
