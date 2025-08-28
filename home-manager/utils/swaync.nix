{vars, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    libnotify
  ];

  catppuccin.swaync = {
    font = vars.fonts.sans-serif.name;
  };

  services.swaync = {
    enable = true;
  };
}
