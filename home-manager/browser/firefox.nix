{...}:

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
  programs.firefox = {
    enable = true;
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
      ];
    };
  };
}
