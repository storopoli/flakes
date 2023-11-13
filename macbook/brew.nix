{ config, pkgs, lib, ... }:

{
  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [
      "homebrew/services"
      "macos-fuse-t/homebrew-cask"
      "thefox/brewery"
    ];
    brews = [
      {
        name = "tor";
        restart_service = true;
      }
      {
        name = "cmus-control";
        restart_service = false; # I am having issues with cmus-remote not being found on PATH
      }
    ];
    casks = [
      "android-file-transfer"
      "bisq"
      "brave-browser"
      "cryptomator"
      "iina"
      "fuse-t"
      "karabiner-elements"
      "keepassxc"
      "netnewswire"
      "notunes"
      "obs"
      "keycastr"
      "orbstack"
      "protonvpn"
      "rectangle"
      "signal"
      "sparrow"
      "tor-browser"
      "transmission"
      "utm"
      "visual-studio-code"
    ];
  };
}
