{pkgs, config, vars, ...}:

let
  extension = shortId: uuid: {
    name = uuid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };
in {
  home.file.passff-host-workaround = {
    target =
      "${config.home.homeDirectory}/.librewolf/native-messaging-hosts/passff.json";
    source = "${pkgs.passff-host}/share/passff-host/passff.json";
  };

  programs.librewolf = {
    enable = true;

    # Configure the "default" profile
    profiles.default = {
      name = "default";
      isDefault = true;
      id = 0;

      # Here we override all the default fonts for Western scripts
      settings = {
        # 0 = serif, 1 = sans‑serif, 2 = monospace, etc.
        "font.default.x-western"        = 1;
        "font.name.serif.x-western"     = vars.fonts.names.serif;
        "font.name.sans-serif.x-western"= vars.fonts.names.sans-serif;
        "font.name.monospace.x-western" = vars.fonts.names.mono;
        # Font sizes (in pixels)
        "font.size.variable.x-western"  = 16;
        "font.minimum-size.x-western"   = 10;

        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.expandOnHover" = true;
        "sidebar.revamp" = true;
        "sidebar.revamp.round-content-area" = true;

        # Allow dark mode requests
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";

        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };

    # Don't know if these are required for librewolf, cbs working it out
    policies = {
      SearchBar = "unified";

      # Add extensions
      ExtensionSettings = builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "passff" "passff@invicem.pro")
      ];
    };
  };
}
