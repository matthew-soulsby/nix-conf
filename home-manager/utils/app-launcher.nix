{pkgs, config, ...}:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "JetBrainsMono Nerd Font:size=14";
        prompt = "\"  \"";
      };
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "f2cdcdff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "f2cdcdff";
        counter = "7f849cff";
        border = "f2cdcdff";
      };
      border = {
        width = 2;
        radius = 10;
      };
    };
  };
}
