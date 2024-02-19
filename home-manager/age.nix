{ config, pkgs, lib, ... }:

{
  age = {
    identityPaths = [
      ../secrets/identities/age-yubikey-identity-95a7c5c3-usb_c.txt
      ../secrets/identities/age-yubikey-identity-2326141d-usb_a.txt
    ];

    secretsDir = "${config.home.homeDirectory}/.agenix/agenix";
    secretsMountPoint = "${config.home.homeDirectory}/.agenix/agenix.d";

    secrets = {
      copilot.file = ../secrets/copilot.age;
    };
  };
}

