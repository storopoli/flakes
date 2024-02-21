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
      "pinentry-mac"
      {
        name = "tor";
        restart_service = true;
      }
      "torsocks"
    ];

    casks = [
      "alacritty"
      "android-file-transfer"
      "brave-browser"
      "bisq"
      "cryptomator"
      "iina"
      "fuse-t"
      "karabiner-elements"
      "keepassxc"
      "mullvadvpn"
      "obs"
      "rectangle"
      "signal"
      "sparrow"
      "stats"
      "tor-browser"
      "transmission"
    ];
  };
}
