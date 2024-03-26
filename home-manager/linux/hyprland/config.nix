{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";

      monitor = ",preferred,auto,1";

      input = {
        kb_layout = "us,us";
        kb_variant = "colemak,altgr-intl";
        kb_model = "";
        kb_rules = "";
        repeat_delay = 200;
        repeat_rate = 30;
        follow_mouse = 2;
        float_switch_override_focus = 2;
        numlock_by_default = true;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = true;
          middle_button_emulation = false;
          "tap-to-click" = false;
          drag_lock = false;
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 3;
        "col.active_border" = "rgb(ffc0cb)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      dwindle = {
        no_gaps_when_only = false;
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_is_master = true;
        special_scale_factor = 0.8;
        no_gaps_when_only = false;
      };

      decoration = {
        multisample_edges = true;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        rounding = 0;
        blur = true;
        blur_size = 3;
        blur_passes = 1;
        blur_new_optimizations = true;
        blur_xray = true;
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        shadow_ignore_window = true;
        dim_inactive = false;
        blur_ignore_opacity = false;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = 1;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [
          "windows, 1, 5, default"
          "windowsOut, 1, 4, default, popin 80%"
          "windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 6, default"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        swallow_regex = "";
        focus_on_activate = true;
      };
      "device:epic mouse V1" = {
        sensitivity = -0.5;
      };

      binds = {
        workspace_back_and_forth = 1;
        allow_workspace_cycles = 1;
      };

      bind = [
        "$mainMod, F1, exec, keybind"
        "$mainMod, F12, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
        #"$mainMod,Return, exec, foot"
        #"$mainMod,Return, exec, foot -e zellij a -c main options --default-shell fish"
        "mainMod,Return, exec, foot -e tmux new -As0"
        "mainMod SHIFT, Return, exec, foot --app-id=\"termfloat\""
        "mainMod, E, exec, nemo"
        "mainMod, Q, killactive,"
        "mainMod SHIFT, Q, exit,"
        "mainMod SHIFT, Space, togglefloating,"
        "mainMod, F, fullscreen"
        "mainMod, Y, pin"
        "mainMod, P, pseudo," # dwindle
        "mainMod, T, togglesplit," # dwindle

        # Toggle grouped layout
        "$mainMod, U, togglegroup,"
        "$mainMod, Tab, changegroupactive, f"

        # change gap
        "$mainMod SHIFT, G, exec, hyprctl --batch \"keyword general:gaps_out 5;keyword general:gaps_in 3\""
        "$mainMod, G, exec, hyprctl --batch \"keyword general:gaps_out 0;keyword general:gaps_in 0\""

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, up, workspace, +1"
        "$mainMod, down, workspace, -1"
        "$mainMod, period, workspace, e+1"
        "$mainMod, comma, workspace,e-1"

        # special workspace(scratchpad)
        "$mainMod, minus, movetoworkspace,special"
        "$mainMod, equal, togglespecialworkspace"

        # move window in current workspace
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, J, movewindow, u"
        "$mainMod SHIFT, K, movewindow, d"

        # Move active window to a workspace with mainMod + ctrl + [0-9]
        "$mainMod CTRL, 1, movetoworkspace, 1"
        "$mainMod CTRL, 2, movetoworkspace, 2"
        "$mainMod CTRL, 3, movetoworkspace, 3"
        "$mainMod CTRL, 4, movetoworkspace, 4"
        "$mainMod CTRL, 5, movetoworkspace, 5"
        "$mainMod CTRL, 6, movetoworkspace, 6"
        "$mainMod CTRL, 7, movetoworkspace, 7"
        "$mainMod CTRL, 8, movetoworkspace, 8"
        "$mainMod CTRL, 9, movetoworkspace, 9"
        "$mainMod CTRL, 0, movetoworkspace, 10"
        "$mainMod CTRL, left, movetoworkspace, -1"
        "$mainMod CTRL, right, movetoworkspace, +1"
        # same as above, but doesnt switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # switch between current and last workspace
        "$mainMod,slash,workspace,previous"

        # quickly launch program
        "$mainMod,B,exec,chromium"
        "$mainMod SHIFT,X,exec,myswaylock"
        ",Print,exec, grimblast --notify --cursor copy area"
        "SHIFT,Print,exec, grimblast --notify --cursor copysave area ~/$(date \"+%Y-%m-%d\"T\"%H:%M:%S\").png"
        "$mainMod,D,exec, pkill rofi || ~/.config/rofi/launcher.sh"
        "$mainMod SHIFT,D,exec, bash ~/.config/rofi/powermenu.sh"

        # control volume,brightness,media players
        ",XF86AudioRaiseVolume,exec, pamixer -i 5"
        ",XF86AudioLowerVolume,exec, pamixer -d 5"
        ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioMicMute,exec, pamixer --default-source -t"
        ",XF86MonBrightnessUp,exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioPause,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"

        # waybar toggle
        "$mainMod,O,exec,killall -SIGUSR1 .waybar-wrapped"

      ];

      exec-once = [
        # wall(by swww service)
        "swww-daemon && default_wall"

        # auto start
        "launch_waybar &"
        "mako &"
        "nm-applet --indicator &"
        "blueman-applet &"
        "swayidle -w timeout 300 'myswaylock -f' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'myswaylock'"
      ];

      windowrule = [
        #`hyprctl clients` get class、title...
        "float,menu"
        "float,title:^(Picture-in-Picture)$"
        "size 960 540,title:^(Picture-in-Picture)$"
        "move 25%-,title:^(Picture-in-Picture)$"
        "float,imv"
        "move 25%-,imv"
        "size 960 540,imv"
        "float,mpv"
        "pin,mpv"
        "move 25%-,mpv"
        "size 960 540,mpv"
        "idleinhibit focus, mpv"
        "float,termfloat"
        "move 25%-,termfloat"
        "size 960 540,termfloat"
        "rounding 5,termfloat"
        "float,nemo"
        "move 25%-,nemo"
        "size 960 540,nemo"
        "float, obs"
        "float,title:^(ssh-askpass)$"
        "noblur,^(firefox)$"
        "noblur,^(chromium)$"
        "idleinhibit fullscreen,class:^(firefox)$"
        "float, title:^(Firefox — Sharing Indicator)$"
        "move 0 0, title:^(Firefox — Sharing Indicator)$"
        "idleinhibit fullscreen,class:^(chromium)$"
      ];

      windowrulev2 = [
        #`hyprctl clients` get class、title...
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:(?:Open|Save) (?:File|Folder|As)"
        "float,class:^(firefox)$,title:(?:Open|Save) (?:File|Folder|As)"
        "float,class:^(Sparrow)$,title:^(Wallet Password)"
        "pin,class:^(Sparrow)$,title:^(Wallet Password)"
        "float,class:^(org.keepassxc.KeePassXC$),"
      ];
    };

    extraConfig = ''
      # resize window
      bind = $mainMod,R,submap,resize
      submap = resize
      binde = ,right,resizeactive,15 0
      binde = ,left,resizeactive,-15 0
      binde = ,up,resizeactive,0 -15
      binde = ,down,resizeactive,0 15
      binde = ,l,resizeactive,15 0
      binde = ,h,resizeactive,-15 0
      binde = ,k,resizeactive,0 -15
      binde = ,j,resizeactive,0 15
      bind = ,escape,submap,reset
      submap = reset

      bind = $mainMod SHIFT, left, resizeactive,-15 0
      bind = $mainMod SHIFT, right, resizeactive,15 0
      bind = $mainMod SHIFT, up, resizeactive,0 -15
      bind = $mainMod SHIFT, down, resizeactive,0 15
      bind = CTRL SHIFT, l, resizeactive, 15 0
      bind = CTRL SHIFT, h, resizeactive,-15 0
      bind = CTRL SHIFT, k, resizeactive, 0 -15
      bind = CTRL SHIFT, j, resizeactive, 0 15

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';

  };
}
