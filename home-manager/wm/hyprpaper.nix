{self, ...}:

let
  wallpaper = ../../assets/landscape_rainworld.png;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
         ",${wallpaper}"
      ];
    };
  };
}
