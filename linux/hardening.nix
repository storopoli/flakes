{ config, lib, pkgs, ... }:
{

  # scudo memory allocato
  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "ZeroContents=1";

  # kernel hardening
  security.lockKernelModules = true;
  security.protectKernelImage = true;
  security.forcePageTableIsolation = true;

  # This is required by podman to run containers in rootless mode.
  security.unprivilegedUsernsClone = config.virtualisation.containers.enable;
  security.virtualisation.flushL1DataCache = "always";

  # app armor
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  # boot kernel parameters
  boot.kernelParams = [
    # Don't merge slabs
    "slab_nomerge"

    # Overwrite free'd pages
    "page_poison=1"

    # Enable page allocator randomization
    "page_alloc.shuffle=1"

    # Disable debugfs
    "debugfs=off"

    # Enable mitigations
    "mitigations=auto,nosmt"

    # Better entropy, may lead to longer boot time
    "random.trust_cpu=off"
    "random.trust_bootloader=off"
  ];

  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  # Networking stuff
  # Enable strict reverse path filtering (that is, do not attempt to route
  # packets that "obviously" do not belong to the iface's network; dropped
  # packets are logged as martians).
  boot.kernel.sysctl."net.ipv4.conf.all.log_martians" = true;
  boot.kernel.sysctl."net.ipv4.conf.all.rp_filter" = "1";
  boot.kernel.sysctl."net.ipv4.conf.default.log_martians" = true;
  boot.kernel.sysctl."net.ipv4.conf.default.rp_filter" = "1";

  # Ignore broadcast ICMP (mitigate SMURF)
  boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = true;

  # Ignore incoming ICMP redirects (note: default is needed to ensure that the
  # setting is applied to interfaces added after the sysctls are set)
  boot.kernel.sysctl."net.ipv4.conf.all.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.all.secure_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.secure_redirects" = false;
  boot.kernel.sysctl."net.ipv6.conf.all.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv6.conf.default.accept_redirects" = false;

  # Ignore outgoing ICMP redirects (this is ipv4 only)
  boot.kernel.sysctl."net.ipv4.conf.all.send_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.send_redirects" = false;

  # enable firewall and block all ports
  #networking.firewall.enable = true; # already defined by networking.nix
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # disable coredump that could be exploited later
  # and also slow down the system when something crash
  systemd.coredump.enable = false;

  # required to run chromium
  security.chromiumSuidSandbox.enable = true;

  # enable firejail
  programs.firejail.enable = true;

  # create system-wide executables firefox and chromium
  # that will wrap the real binaries so everything
  # work out of the box.
  programs.firejail.wrappedBinaries = {
    #firefox = {
    #    executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
    #    profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
    #};

    chromium = {
      executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
      profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
    };

    tor-browser = {
      executable = "${pkgs.tor-browser-bundle-bin}/bin/tor-browser";
      profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
    };

    signal-desktop = {
      executable = "${pkgs.lib.getBin pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
      profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
      extraArgs = [ "--env=GTK_THEME=Adwaita:dark" ];
    };

    keepassxc = {
      executable = "${pkgs.lib.getBin pkgs.keepassxc}/bin/keepassxc";
      profile = "${pkgs.firejail}/etc/firejail/keepassxc.profile";
    };

    mpv = {
      executable = "${pkgs.lib.getBin pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };

    transmission-gtk = {
      executable = "${pkgs.lib.getBin pkgs.transmission_4-gtk}/transmission-gtk";
      profile = "${pkgs.firejail}/transmission-gtk.profile";
    };
  };

  # enable antivirus clamav and
  # keep the signatures' database updated
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
