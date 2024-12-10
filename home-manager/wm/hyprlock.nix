{vars, ...}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = [
        "${../../assets/hyprland/mocha.conf}"
      ];

      "$accent" = "$red";
      "$accentAlpha" = "$flamingoAlpha";
      "$font" = "JetBrainsMono Nerd Font";
      "$mainMonitor" = "eDP-1";

      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "${vars.wallpaper}";
          blur_passes = 3;
          blur_size = 3;
          color = "$base";
        }
      ];

      image = [
        # Portrait
        {
          monitor = "$mainMonitor";
          path = "${vars.portrait}";
          border_size = 2;
          border_color = "rgba(255, 255, 255, 0)";
          size = 130;
          rounding = -1;
          rotate = 0;
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        # Userbox
        {
          monitor = "$mainMonitor";
          size = "300, 60";
          color = "rgba(255, 255, 255, .1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(253, 198, 135, 0)";
          rotate = 0;
          xray = false;
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];
    
      label = [
        # Date
        {
          monitor = "$mainMonitor";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 25;
          font_family = "$font";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
    
        # Time
        {
          monitor = "$mainMonitor";
          text = "cmd[update:1000] echo \"<span>$(date +\"%I:%M\")</span>\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 120;
          font_family = "$font";
          position = "0, 250";
          halign = "center";
          valign = "center";
        }

        # Username
        {
          monitor = "$mainMonitor";
          text = "  $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 14;
          font_family = "$font";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];
    
      input-field = [
        {
          monitor = "$mainMonitor";
          size = "300, 60";
          outline_thickness = 0;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          swap_font_color = true;
          check_color = "$flamingo";
          fail_color = "$red";
          fade_on_empty = false;
          font_family = "$font";
          placeholder_text = "<span foreground=\"##ffffff99\">  Password</span>";
          fail_text = "<span>$FAIL</span>";
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
