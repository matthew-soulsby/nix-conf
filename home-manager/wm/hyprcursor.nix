{
  config,
  pkgs, 
  ...
}:

{
  #home.file."${config.home.homeDirectory}/.icons/catppuccin-mocha-dark-cursors".source = config.lib.file.mkOutOfStoreSymlink ../../assets/catppuccin-mocha-dark-cursors;
/*
  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "catppuccin-mocha-dark-cursors";
    };
  };*/

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 24;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/catppuccin/cursors/releases/download/v1.0.2/catppuccin-mocha-dark-cursors.zip"
        "sha256-lmGwkipTwdb6jIhDs3dFMj3aVN3LJhxK+M+I7q0syoc="
        "catppuccin-mocha-dark-cursors";

  home.packages = with pkgs; [
    hyprcursor
  ];
}
