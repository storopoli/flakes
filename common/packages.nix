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
    ripgrep
    fd
    sd
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
    go
    python3
    typescript
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
