{ ... }:

{
  age = {
    secrets = {
      reserves1.file = ../secrets/reserves1.age;
      reserves2.file = ../secrets/reserves2.age;
      luks.file = ../secrets/luks.age;
      password.file = ../secrets/password.age;
    };
    identityPaths = [
      ../secrets/identities/age-yubikey-identity-95a7c5c3-usb_c.txt
      ../secrets/identities/age-yubikey-identity-2326141d-usb_a.txt
    ];
  };
}
