{pkgs, ...}:

{
  home.packages = with pkgs; [
    pure-prompt
  ];

  programs.zsh = {
    enable = true;
  };
}
