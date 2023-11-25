{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cava
    ];

    file = {
      ".config/cava/config".source = ./config;
      ".config/cava/config1".source = ./config1;
    };
  };
}
