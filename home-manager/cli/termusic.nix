{ ... }:

{
  xdg.configFile."termusic/themes/catppuccin.theme".source = builtins.fetchurl {
    url =
      "https://github.com/catppuccin/alacritty/raw/406dcd431b1e8866533798d10613cdbab6568619/catppuccin-mocha.yml";
    sha256 =
      "0hqajv41pgaj9z8797wzwbyf3g9lz9qjjkwzs1wbrzh0zysyzi6v";
  };
}
