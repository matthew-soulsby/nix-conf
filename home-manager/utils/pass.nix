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
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-import
    ]);
  };
}
