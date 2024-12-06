{...}:

{
  programs.waybar = {
    enable = true;
    style = ''
      ${builtins.readFile ../../assets/waybar/mocha.css}
      
      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 14px;
        min-height: 0;
      }
      
      #waybar {
        background: alpha(@base, 0.6);
        color: @text;
        margin: 5px 5px;
      }
      
      #window {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        color: @lavender;
        margin-left: 1rem;
        padding-left: 1rem;
        padding-right: 1.1rem;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }
      
      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
        padding-right: 0.6rem;
      }
      
      #workspaces button.active {
        color: @flamingo;
        border-radius: 1rem;
      }
      
      #workspaces button:hover {
        color: @mauve;
        border-radius: 1rem;
      }
      
      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 1rem;
        margin: 5px 0;
      }
      
      #clock {
        color: @blue;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 1rem;
      }
      
      #battery {
        color: @green;
      }
      
      #battery.charging {
        color: @green;
      }
      
      #battery.warning:not(.charging) {
        color: @red;
      }
      
      #network {
        color: @yellow;
        padding-right: 1.2rem;
      }
      
      #backlight, #battery, #network {
          border-radius: 0;
      }
      
      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }
      
      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }
      
      #custom-lock {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
      }
      
      #custom-power {
          margin-right: 1rem;
          border-radius: 0px 1rem 1rem 0px;
          color: @red;
          padding-right: 1.1rem;
      }
      
      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
      }
    '';
    settings = [
      {
        layer = "top";
        position = "top";

        modules-center = [
          "hyprland/window"
        ];
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = [ 
          "pulseaudio"
          "battery"
          "network"
          "clock"
          "tray"
          "custom/lock"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "hyprland/window" = {
          max-length = 30;
          separate-outputs = false;
          icon = true;
          icon-size = 18;
          rewrite = {
            "" = "󱄅";
          };
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "clock" = {
          format = ''  {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d %B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "  {format_source}";
          format-source = " 󰍬";
          format-source-muted = " 󰍭";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };

        network = {
          interval = 1;
          tooltip-format = "{essid}: {ipaddr}";
          format-disconnected = "⚠";
          format-ethernet = "";
          format-linked = "󰌘";
          format-wifi = "  {signalStrength}%";
          on-click = "networkmanager_dmenu";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };

        "custom/lock" = {
          tooltip = false;
          on-click = "hyprlock";
          format = "";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "";
        };
      }
    ];
  };
}
