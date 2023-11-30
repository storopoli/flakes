{ ... }:

{
  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = [
      "homebrew/services"
      "macos-fuse-t/homebrew-cask"
      "thefox/brewery"
    ];
    brews = [
      "pinentry-mac"
      {
        name = "tor";
        restart_service = true;
      }
      "torsocks"
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
    ];
  };
}
