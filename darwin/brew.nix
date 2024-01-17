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
      "aichat" # TODO: move to nixpkgs
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
      "keycastr"
      "mullvadvpn"
      "microsoft-teams"
      "obs"
      "rectangle"
      "signal"
      "sparrow"
      "stats"
      "tor-browser"
      "transmission"
      "vscodium"
    ];
  };
}
