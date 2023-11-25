{ ... }:

{
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      # set to 10 minutes for regular ttl, and 2 hours for max ttl
      default-cache-ttl 600
      max-cache-ttl 7200
      default-cache-ttl-ssh 600
      max-cache-ttl-ssh 7200
      # enable SSH support
      enable-ssh-support
    '';
  };
}
