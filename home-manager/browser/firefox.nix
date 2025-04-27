{pkgs, config, vars, ...}:

let
  extension = shortId: uuid: {
    name = uuid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  lock-value = value: {
    Value = value;
    Status = "locked";
  };
in {
  home.file.passff-host-workaround = {
    target =
      "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/passff.json";
    source = "${pkgs.passff-host}/share/passff-host/passff.json";
  };

  programs.firefox = {
    enable = true;

    # Configure the "default" profile
    profiles.default = {
      # (Optional) give it a human‑readable name, if you like:
      name = "default";
      isDefault = true;
      id = 0;

      # Here we override all the default fonts for Western scripts
      settings = {
        # 0 = serif, 1 = sans‑serif, 2 = monospace, etc.
        "font.default.x-western"        = 1;
        # Choose your preferred serif/sans‑serif/monospace fonts
        "font.name.serif.x-western"     = vars.fonts.names.serif;
        "font.name.sans-serif.x-western"= vars.fonts.names.sans-serif;
        "font.name.monospace.x-western" = vars.fonts.names.mono;
        # Font sizes (in pixels)
        "font.size.variable.x-western"  = 16;
        "font.minimum-size.x-western"   = 10;
      };
    };

    nativeMessagingHosts = with pkgs; [
      #passff-host
    ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      SearchBar = "unified";

      Preferences = {
        "browser.newtab.extensionControlled" = lock-value false;
        "sidebar.verticalTabs" = lock-value true;
        "sidebar.expandOnHover" = lock-value true;
        "sidebar.revamp" = lock-value true;
        "sidebar.revamp.round-content-area" = lock-value true;
      };

      # Add extensions
      ExtensionSettings = builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        #(extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
        (extension "passff" "passff@invicem.pro")
      ];
    };
  };
}
