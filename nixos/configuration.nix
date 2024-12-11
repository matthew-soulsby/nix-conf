# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    #inputs.hardware.nixosModules.common-cpu-amd
    #inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # System wide app config
    ./hyprland.nix
    ./greetd.nix
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
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      trusted-users = [
        "root"
        "@wheel"
        "mattsoulsby"
      ];
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Bootloader.
  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    # Silent boot - https://wiki.nixos.org/wiki/Plymouth
    consoleLogLevel = 0;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    plymouth.enable = true;
  };

  # Enable networking
  #networking.networkmanager.enable = true;
  systemd.network = {
    enable = true;

    wait-online = {
      enable = false;
      anyInterface = true;
    };
    networks = let
      networkConfig = {
        DHCP = "yes";
        DNSSEC = "yes";
        DNSOverTLS = "yes";
        DNS = [
         "1.1.1.1"
         "1.0.0.1"
        ];
        IPv4Forwarding = "yes";
        IPv6Forwarding = "yes";
        IPv6AcceptRA = "yes";
      };
    in {
      "10-wired" = {
        matchConfig.Type = "ether";
        inherit networkConfig;
        dhcpV4Config = {
          Use6RD = "yes";
          RouteMetric = 512;
          DUIDType = "link-layer";
        };
        dhcpV6Config = {
          RouteMetric = 512;
          DUIDType = "link-layer";
          PrefixDelegationHint = "::64";
        };
      };
      "10-wireless" = {
        matchConfig.Type = "wlan";
        inherit networkConfig;
        dhcpV4Config = {
          RouteMetric = 1500;
          DUIDType = "link-layer";
          Use6RD = "yes";
        };
        dhcpV6Config = {
          RouteMetric = 1500;
          DUIDType = "link-layer";
          PrefixDelegationHint = "::64";
        };
      };
    };
  };

  networking = {
    hostName = "nix-laptop";
    useNetworkd = true;
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6 = {
          Enabled = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    system76 = {
      power-daemon.enable = true;
    };
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    home-manager
    kitty
  ];

  users.users = {
    mattsoulsby = {
      description = "Matthew Soulsby";
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "audio"];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ 
        "FiraCode"
        "RobotoMono"
        "JetBrainsMono"
      ]; })
    ];
    fontconfig.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
