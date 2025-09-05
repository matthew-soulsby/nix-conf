{pkgs, ...}:

{
    programs.hyprpanel = {
        enable = true;
        settings = {
            scalingPriority = "hyprland";

            bar = {
                launcher.autoDetectIcon = true;
                clock.format = "%I:%M %p";

                workspaces = {
                    show_icons = true;
                    ignored = "-";
                };

                layouts = {
                    "*" = {
                      left = [
                        "workspaces"
                        "windowtitle"
                      ];
                      middle = [
                        "media"
                      ];
                      right = [
                        "volume"
                        "network"
                        "bluetooth"
                        "battery"
                        "systray"
                        "clock"
                        "notifications"
                        "dashboard"
                      ];
                    };
                };
            };

            menus = {
                power.lowBatteryNotification = true;

                dashboard = {
                    powermenu.avatar.image = "/home/mattsoulsby/nix-conf/assets/portraits/ai-small-body.jpg";

                    shortcuts.left = {
                        shortcut1 = {
                            icon = "󰈹";
                            command = "librewolf";
                            tooltip = "Librewolf";
                        };
                        shortcut4.command = "~/.config/rofi/launchers/type-1/launcher.sh";
                    };
                };

                clock = {
                    time.military = false;

                    weather = {
                        location = "Melbourne";
                        unit = "metric";
                        key = "/home/mattsoulsby/secrets/weather_api_key";
                    };
                };
            };

            theme = {
                font.weight = 500;
                bar = {
                    opacity = 70;
                    outer_spacing = "0.4em";
                    buttons = {
                        radius = "0.6em";
                        style = "split";
                    };
                    menus = {
                        enableShadow = true;
                        shadowMargins = "7px 7px";
                        shadow = "0px 0px 0px 0px #16161e";
                    };
                };
            };
        };
    };
}
