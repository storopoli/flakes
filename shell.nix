{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  shellHook = ''
          echo "
     ______   _           _                 
    |  ____| | |         | |                
    | |__    | |   __ _  | | __   ___   ___ 
    |  __|   | |  / _\` | | |/ /  / _ \ / __|
    | |      | | | (_| | |   <  |  __/ \\__ \\
    |_|      |_|  \__,_| |_|\_\  \___| |___/
          "
            export PS1="[\e[0;34m(Flakes)\$\e[m:\w]\$ "
            export EDITOR=nvim
  '';
  nativeBuildInputs = with pkgs; [
    bashInteractive
    git
    sbctl
    neovim
    age
    age-plugin-yubikey
  ];
}
