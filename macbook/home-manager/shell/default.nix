{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish
    ./ssh.nix
    ./git.nix
    ./tmux.nix
    ./gpg.nix
  ];
}
