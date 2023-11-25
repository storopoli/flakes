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
    ./wayland.nix
  ];
  users.users.user = {
    # TODO: fix password with agenix
    initialHashedPassword =
      "$6$MaOkIaWVTcGTX0Ec$5trnAnfzqMYsoggvBbjBcP.SPxx/B1fqsQxLfKU26QMerrG0QmRnaofCT3/K0LBk9aLeiPDjledO7Sdh9yv161";
    isNormalUser = true;
    extraGroups =
      [ "wheel" "docker" "libvirtd" "video" "audio" "networkmanager" ];
  };
}
