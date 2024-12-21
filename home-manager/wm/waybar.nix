{pkgs, ...}:

let
  waybarDeps = with pkgs; [
    pwvucontrol
    wireplumber
    blueberry
  ];
in {
  home.packages = waybarDeps;
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
      #wireplumber,
      #bluetooth,
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
      
      #backlight, 
      #battery, 
      #network,
      #bluetooth {
          border-radius: 0;
      }

      #bluetooth {
        color: @mauve;
      }
      
      #pulseaudio,
      #wireplumber {
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

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [ 
          "wireplumber"
          "battery"
          "network"
          "bluetooth"
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
          icon-size = 14;
          spacing = 10;
        };

        "clock" = {
          format = ''  {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d %B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          on-click = "swaync-client -t -sw";
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
          on-click = "pavucontrol";
        };

        "wireplumber" = {
          format = "{icon}  {volume}%";
          format-muted = "  ";
          format-icons = [
            ""
            ""
            ""
          ];
          on-click = "pwvucontrol";
        };

        network = {
          interval = 1;
          tooltip-format = "{ifname} - Connected";
          tooltip-format-wifi = "{essid}: {ipaddr}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          format-disconnected = "⚠";
          format-ethernet = "";
          format-linked = "󰌘";
          format-wifi = "  {signalStrength}%";
          on-click = "iwgtk";
        };

        "bluetooth" = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-icons = [
            "󰤾"
            "󰤿"
            "󰥀"
            "󰥁"
            "󰥂"
            "󰥃"
            "󰥄"
            "󰥅"
            "󰥆"
            "󰥈"
          ];
          tooltip-format = "Bluetooth {status}";
          tooltip-format-connected = "Bluetooth {status}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{icon} {device_battery_percentage}%";
          on-click = "blueberry";
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
          tooltip = true;
          on-click = "~/.config/rofi/applets/bin/battery.sh";
        };

        "custom/lock" = {
          tooltip = false;
          on-click = "hyprlock";
          format = "";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "~/.config/rofi/powermenu/type-2/powermenu.sh";
          format = "";
        };
      }
    ];
  };
}
