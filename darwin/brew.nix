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
      "aichat"
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
      "chromium"
      "cryptomator"
      "iina"
      "fuse-t"
      "karabiner-elements"
      "keepassxc"
      "keycastr"
      "mullvadvpn"
      "microsoft-teams"
      "obs"
      "rectangle"
      "signal"
      "sparrow"
      "tor-browser"
      "transmission"
      "vscodium"
    ];
  };
}
