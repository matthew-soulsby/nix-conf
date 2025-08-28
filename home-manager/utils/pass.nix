{pkgs, ...}:

{
  home.packages = with pkgs; [
    pinentry-qt
  ];

  programs.gpg = {
    enable = true;
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-import
    ]);
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };
}
