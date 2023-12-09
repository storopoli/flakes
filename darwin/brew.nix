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
    ];

    brews = [
      "wireguard-tools"
      "pinentry-mac"
      {
        name = "tor";
        restart_service = true;
      }
      "torsocks"
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
      "obs"
      "keycastr"
      "rectangle"
      "signal"
      "sparrow"
      "tor-browser"
      "transmission"
    ];
  };
}
