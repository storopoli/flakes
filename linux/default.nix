{ ... }:

{
  imports = [
    ./system.nix
    ./filesystem.nix
    ./networking.nix
    ./packages.nix
    ./bluetooth.nix
    ./amd.nix
    # ./intel.nix
    ./fonts.nix
  ];
}
