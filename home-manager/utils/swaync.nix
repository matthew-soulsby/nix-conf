{vars, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    libnotify
  ];

  catppuccin.swaync = {
    font = vars.fonts.names.sans-serif;
  };

  services.swaync = {
    enable = true;
  };
}
