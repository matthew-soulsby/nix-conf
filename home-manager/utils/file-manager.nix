{pkgs, ...}:

{
  home.packages = with pkgs; [
    xfce.thunar
  ];
  programs = {
    yazi = {
      enable = true;
    };
    imv.enable = true;
    mpv.enable = true;
  };
}
