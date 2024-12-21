{pkgs, ...}:

{
  home.packages = with pkgs; [
    libnotify
  ];

  services.swaync = {
    enable = true;
    style = ../../assets/swaync/mocha.css;
  };
}
