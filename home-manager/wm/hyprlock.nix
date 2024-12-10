{vars, ...}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = [
        "${../../assets/hyprland/mocha.conf}"
      ];

      "$accent" = "$flamingo";
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

      label = [
        # Layout
        {
          monitor = "$mainMonitor";
          text = "Layout: $LAYOUT";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "30, -30";
          halign = "left";
          valign = "top";
        }
        # Time
        {
          monitor = "$mainMonitor";
          text = "$TIME";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        # Date
        {
          monitor = "$mainMonitor";
          text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      image = [
        {
          monitor = "$mainMonitor";
          path = "${vars.portrait}";
          size = 100;
          border_color = "$accent";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "$mainMonitor";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = "0.2";
          dots_spacing = "0.2";
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##$textAlpha\">󰌾  Logged in as <span foreground=\"##$accentAlpha\">$USER</span></span>";
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
