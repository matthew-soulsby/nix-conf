{lib, config, ...}:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "mattsoulsby";
      };/*
      initial_session = {
        command = "${lib.getExe config.programs.hyprland.package} --config /etc/greetd/hyprland.conf";
        user = "greeter";
      };*/
    };
  };
}
