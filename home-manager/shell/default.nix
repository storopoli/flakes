{ ... }:

{
  imports = [
    ./fish
    #./vim
    ./neovim.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./tmux.nix
  ];
}
