{
  config,
  pkgs, 
  ...
}:

let 
  getFrom = url: hash: name: pkgs.runCommand "moveUp" {} ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.fetchzip {
      url = url;
      hash = hash;
    }} $out/share/icons/${name}
  '';
  cursorName = "catppuccin-mocha-dark-cursors";
  cursorPackage = getFrom 
    "https://github.com/catppuccin/cursors/releases/download/v1.0.2/catppuccin-mocha-dark-cursors.zip"
    "sha256-lmGwkipTwdb6jIhDs3dFMj3aVN3LJhxK+M+I7q0syoc="
    "catppuccin-mocha-dark-cursors";
in {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 24;
    package = cursorPackage;
    name = cursorName;
  };

  home.packages = with pkgs; [
    hyprcursor
  ];
}
