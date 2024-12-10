{self, vars, ...}:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${vars.wallpaper}"
      ];
      wallpaper = [
         ",${vars.wallpaper}"
      ];
    };
  };
}
