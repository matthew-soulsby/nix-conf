{pkgs, config, ...}:

{
  home.packages = with pkgs; [
    networkmanager_dmenu
  ];

  home.file."${config.home.homeDirectory}/.config/networkmanager-dmenu/config.ini".source = (pkgs.formats.ini {}).generate "nil" {
    dmenu = {
      dmenu_command = "fuzzel -d";
    };

    editor = {
      terminal = "alacritty";
    };
  };
}
