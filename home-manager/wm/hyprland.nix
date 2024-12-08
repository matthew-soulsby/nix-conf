{pkgs, ...}:
 
let 
  hyprland_deps = with pkgs; [
    brightnessctl
    playerctl
  ];
in {
  home.packages = hyprland_deps;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Theme
      source = [
        "${../../assets/hyprland/mocha.conf}"
      ];

      general = {
        "col.active_border" = "$lavender $flamingo 45deg";
        "col.inactive_border" = "$base";
        gaps_out = 10;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        inactive_opacity = 0.8;
      };

      # Binds
      "$terminal" = "kitty";
      "$mod" = "SUPER";
      "$browser" = "firefox";
      "$cbmanager" = "clipse";
      "$launcher" = "fuzzel";

      monitor = [
        "eDP-1, 2880x1800@120, 0x0, 1.5"
        "DP-3, highrr, auto-up, 1.6"
      ];

      env = [
        "HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_THEME,catppuccin-mocha-dark-cursors"
        "XCURSOR_SIZE,32"
        "NIXOS_OZONE_WL,1"
      ];

      bind = [
        "$mod, T, exec, $terminal"
        "$mod, B, exec, $browser"
        "$mod, M, exit,"
        "$mod, Q, killactive,"
        "$mod, E, togglefloating,"
        "$mod, C, togglesplit,"
        "$mod, V, exec, $terminal --class clipse -e clipse"
        "$mod, R, exec, $launcher" 

        # Toggle fullscreen
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, F, fullscreen, 1"
        
        # Move between panes
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move panes
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 0"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      gestures = {
        workspace_swipe = true;
      };

      layerrule = [
        "blur, waybar"
        "blur, logout_dialog"
      ];

      windowrule = [];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float, class:($cbmanager)"
        "size 622 652, class:($cbmanager)"
        "float, class:(iwgtk|pavucontrol)"
        "move onscreen 75% 5%, class:(iwgtk|pavucontrol)"
      ];

      exec-once = [
        "waybar"
        "hyprctl setcursor catppuccin-mocha-dark-cursors 32"
        "hyprpaper"
        "hypridle"
        "hyprlock"
        "blueman-applet"
      ];
    };
  };
}
