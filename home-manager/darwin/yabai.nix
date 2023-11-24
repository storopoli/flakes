{ ... }:

{
  home.file = {
    yabai = {
      executable = true;
      target = ".config/yabai/yabairc";
      text = ''
        #!/usr/bin/env sh

        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        # default layout
        yabai -m config layout bsp

        # New window spawns to the right if vertical split, or bottom if horizontal split
        yabai -m config window_placement second_child

        # padding set to 12px
        yabai -m config top_padding 12
        yabai -m config bottom_padding 12
        yabai -m config left_padding 12
        yabai -m config right_padding 12
        yabai -m config window_gap 12

        # leave my mouse alone
        yabai -m config focus_follow_mouse off

        # set mouse interaction modifier key (default: fn)
        yabai -m config mouse_modifier cmd

        # set modifier + left-click drag to move window (default: move)
        yabai -m config mouse_action1 move

        # set modifier + right-click drag to resize window (default: resize)
        yabai -m config mouse_action2 resize

        # when window is dropped in center of another window, swap them (on edges it will split it)
        yabai -m mouse_drop_action swap


        # rules
        yabai -m rule --add app="^System Settings$"    manage=off
        yabai -m rule --add app="^System Information$" manage=off
        yabai -m rule --add app="^System Preferences$" manage=off
        yabai -m rule --add title="Preferences$"       manage=off
        yabai -m rule --add title="Settings$"          manage=off
        yabai -m rule --add title="^Wallet Password"   manage=off
        yabai -m rule --add app="^Calculator$"         manage=off
        yabai -m rule --add app="^Karabiner-Elements$" manage=off
        yabai -m rule --add app="^KeePassXC$"          manage=off
        yabai -m rule --add app="^IINA$"               manage=off
        yabai -m rule --add app="^ProtonVPN$"          manage=off

        echo "yabai configuration loaded"
      '';
    };

    skhd = {
      target = ".config/skhd/skhdrc";
      text = let yabai = "/opt/homebrew/bin/yabai"; in
        ''
          # focus window
          cmd - j : ${yabai} -m window --focus north
          cmd - k : ${yabai} -m window --focus south
          cmd - h : ${yabai} -m window --focus west
          cmd - l : ${yabai} -m window --focus east

          # swap managed window
          shift + cmd - j : ${yabai} -m window --swap north
          shift + cmd - k : ${yabai} -m window --swap south
          shift + cmd - h : ${yabai} -m window --swap west
          shift + cmd - l : ${yabai} -m window --swap east

          # toggle window float
          shift + cmd - space : ${yabai} -m window --toggle float --grid 4:4:1:1:2:2

          # maximize a window:w:
          shift + cmd - f : ${yabai} -m window --toggle zoom-fullscreen

          # balance out tree of windows (resize to occupy same area)
          shift + cmd - escape : ${yabai} -m space --balance

          # focus space
          cmd - 1 : ${yabai} -m space --focus 1
          cmd - 2 : ${yabai} -m space --focus 2
          cmd - 3 : ${yabai} -m space --focus 3
          cmd - 4 : ${yabai} -m space --focus 4
          cmd - 5 : ${yabai} -m space --focus 5
          cmd - 6 : ${yabai} -m space --focus 6
          cmd - 7 : ${yabai} -m space --focus 7
          cmd - 8 : ${yabai} -m space --focus 8
          cmd - 9 : ${yabai} -m space --focus 9
          cmd - 0 : ${yabai} -m space --focus 10

          # move window to space #
          shift + cmd - 1 : ${yabai} -m window --space 1;
          shift + cmd - 2 : ${yabai} -m window --space 2;
          shift + cmd - 3 : ${yabai} -m window --space 3;
          shift + cmd - 4 : ${yabai} -m window --space 4;
          shift + cmd - 5 : ${yabai} -m window --space 5;
          shift + cmd - 6 : ${yabai} -m window --space 6;
          shift + cmd - 7 : ${yabai} -m window --space 7;
          shift + cmd - 8 : ${yabai} -m window --space 8;
          shift + cmd - 9 : ${yabai} -m window --space 9;
          shift + cmd - 0 : ${yabai} -m window --space 10;

          # application launcher
          cmd - d : open -b com.apple.launchpad.launcher
          shift + cmd - d : open -b com.apple.exposelauncher
        '';
    };
  };
}
