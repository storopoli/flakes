{ pkgs, ... }:

let
  rust = pkgs.rust-bin.stable.latest.default.override {
    targets = [ "wasm32-unknown-unknown" ];
  };
in
{
  # System-Wide Packages
  environment.systemPackages = with pkgs; [
    # Terminal
    tree
    parallel
    curl
    rsync
    bc
    jq
    just
    ueberzugpp

    # git
    gh

    # ssh
    openssh
    ssh-copy-id

    # age
    age-plugin-yubikey
    age
    agenix

    # archive
    xz
    zstd
    lz4
    p7zip

    # programming
    rust
    julia-bin
    python3
    llvm
    luajit

    # media
    termusic
    ffmpeg
    qpdf
    graphicsmagick
    aria2
    pandoc
    tectonic
    typst
  ];
}
