{pkgs, config, ...}:

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
      };

      # Add extensions
      ExtensionSettings = builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
        (extension "passff" "passff@invicem.pro")
      ];
    };
  };
}
