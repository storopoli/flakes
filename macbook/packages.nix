{ config, pkgs, lib, inputs, ... }:

let
  rust = pkgs.rust-bin.stable.latest.default.override {
    targets = [ "wasm32-unknown-unknown" ];
  };
in
{
  environment = {
    shells = with pkgs; [ fish ]; # Default Shell

    variables = {
      # Environment Variables
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # System-Wide Packages
    systemPackages = with pkgs; [
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
      ueberzugpp
      pinentry_mac

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

      # tor
      # tor # does not work, activate on brew
      torsocks

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
  };
}
