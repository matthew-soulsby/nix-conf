{pkgs, vars, ...}:

{
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.roboto-mono
    ] ++ builtins.map (x: x.package) (builtins.attrValues vars.fonts);
}
