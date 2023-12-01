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
    fd
    sd
    parallel
    curl
    rsync
    bc
    jq
    just
    broot
    du-dust
    ncdu
    tre-command
    ueberzugpp

    # git
    gh
    git-absorb

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
    cargo-nextest
    cargo-cache
    cargo-show-asm
    julia-bin
    go
    python3
    llvm

    # media
    cmus
    ffmpeg
    qpdf
    graphicsmagick
    aria2
    pandoc
    glow
    tectonic
    typst
  ];
}
