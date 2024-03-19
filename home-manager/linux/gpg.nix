{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    # set to 10 minutes for regular ttl, and 2 hours for max ttl
    defaultCacheTtl = 600;
    defaultCacheTtlSsh = 600;
    maxCacheTtl = 7200;
    maxCacheTtlSsh = 7200;
  };
}
