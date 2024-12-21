# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    inputs.walker.homeManagerModules.default

    # Window manager
    ./wm/hyprland.nix
    ./wm/hyprlock.nix
    ./wm/hyprpaper.nix
    ./wm/hypridle.nix
    ./wm/waybar.nix
    ./wm/hyprcursor.nix

    # Browser
    ./browser/firefox.nix

    # Clipboard
    ./utils/clipboard.nix

    # Terminal
    ./term/kitty.nix

    # ZSH Shell
    ./shell/zsh.nix
    ./shell/tmux.nix

    # File Managers
    ./utils/file-manager.nix

    # App Launcher
    ./utils/app-launcher.nix
    ./rofi/rofi.nix

    # Notifications
    ./utils/swaync.nix

    # Network Manager
    ./utils/iwgtk.nix

    # Logout Screen
    ./utils/wlogout.nix

    # CLI utilities
    ./utils/cli.nix

    # Passwords
    ./utils/pass.nix

    # Editor
    ./editor/nvim/nvim.nix

    # Apps
    ./apps/git.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "mattsoulsby";
    homeDirectory = "/home/mattsoulsby";
  };

  # Theme
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    font.name = "RobotoMono Nerd Font 18";
    theme = {
      name = "Catppuccin-GTK-Purple-Dark";
      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = [ "purple" ];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
