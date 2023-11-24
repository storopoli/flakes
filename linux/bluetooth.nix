{ ... }:

{
  hardware.bluetooth.enable = true;
  services = {
    blueman.enable = true;
    pcscd.enable = true; # smartcard support
  };
}
