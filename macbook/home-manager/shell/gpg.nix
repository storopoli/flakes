{ config, pkgs, lib, ... }:

{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    settings = {
      default-key = "0xDDAC7E0DD0488D36!";
      # This is an implementation of the Riseup OpenPGP Best Practices
      # https://help.riseup.net/en/security/message-security/openpgp/best-practices
      no-emit-version = true;
      no-comments = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      use-agent = true;
      keyserver = "hkps://keys.openpgp.org/";
      keyserver-options = "no-honor-keyserver-url include-revoked";
      personal-cipher-preferences = "AES256 AES192 AES CAST5";
      personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224";
      cert-digest-algo = "SHA512";
      default-preference-list =
        "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      # set to 30 minutes for regular ttl, and 2 hours for max ttl
      default-cache-ttl 1800
      max-cache-ttl 7200
      # enable SSH support
      enable-ssh-support
    '';
    ".gnupg/sshcontrol".text = ''
      DF0AA528163BDAADD3D9FD68051A12C04A4533B4
    '';
  };
}
