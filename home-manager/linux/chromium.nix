{ ... }:

{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--js-flags=--jitless" # remove JIT
    ];
  };
}

