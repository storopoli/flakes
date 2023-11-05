{ config, pkgs, lib, ... }:

{
  imports = [
    ./fzf.nix
    ./ripgrep.nix
    ./bat.nix
    ./broot.nix
    ./zoxide.nix
    ./yazi.nix
    ./eza.nix
    # ./btop.nix
    ./bottom.nix
    ./direnv.nix
    ./lazygit.nix
    ./ncdu.nix
    ./yt-dlp.nix
    ./cmus.nix
  ];
}
