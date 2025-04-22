{pkgs, vars, ...}:

{
    fonts.fontconfig.enable = true;
    home.packages = [
        (pkgs.nerdfonts.override { fonts = [ 
            "FiraCode" 
            "RobotoMono" 
            "JetBrainsMono"
        ] ++ builtins.attrValues vars.fonts.packages ;})
    ];
}
