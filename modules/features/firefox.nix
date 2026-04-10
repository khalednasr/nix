{ lib, ... }:
{
  den.aspects.firefox.homeManager = {
    programs.firefox = {
      enable = true;

      languagePacks = [
        "en-GB"
        "de"
      ];

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        OverrideFirstRunPage = "";
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            # Bitwarden
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          "uBlock0@raymondhill.net" = {
            # uBlock Origin
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          "addon@darkreader.org" = {
            # Darkreader
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            # Vimium
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          "transmitter@unrelenting.technology" = {
            # Transmission
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/transmitter-for-transmission/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
      };

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          search = {
            default = "google";
            privateDefault = "google";
            force = true;
          };

          settings = {
            # Home page
            "browser.startup.homepage" = "https://this-page-intentionally-left-blank.org";

            # Bookmarks bar
            "browser.toolbars.bookmarks.visibility" = "never";

            # Theme
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.theme.content-theme" = 0;
            "browser.theme.toolbar-theme" = 0;
            "extensions.colorway-builtin-themes-cleanup" = 1;

            # Translation
            "browser.translations.automaticallyPopup" = false;

            # Disable AI chat
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.sidebar" = false;

            # # UI state
            "browser.uiCustomization.state" =
              ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["ublock0_raymondhill_net-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","transmitter_unrelenting_technology-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","unified-extensions-button","addon_darkreader_org-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"vertical-tabs":[],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","transmitter_unrelenting_technology-browser-action","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","screenshot-button"],"dirtyAreaCache":["nav-bar","vertical-tabs","unified-extensions-area","PersonalToolbar","toolbar-menubar","TabsToolbar"],"currentVersion":23,"newElementCount":2}'';
          };
        };
      };
    };

    home.file."./.config/vimium/vimium-options.json".text =
      # "keyMappings": "map J previousTab\nmap K nextTab",
      # "searchEngines": "w: https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s Wikipedia\nd: https://www.duckduckgo.com/search?q=%s DuckDuckGo\ng: https://www.google.com/search?q=%s Google\ny: https://www.youtube.com/results?search_query=%s Youtube\ngm: https://www.google.com/maps?q=%s Google Maps\nnxp: https://search.nixos.org/packages?channel=unstable&query=%s NixOS Packages\nnxo: https://search.nixos.org/options?channel=unstable&query=%s NixOS Options\nhmo: https://home-manager-options.extranix.com/?query=%s&release=master Home Manager Options",
      let
        keyMappings = lib.concatStringsSep "\\n" [
          "map H previousTab"
          "map L nextTab"
          "map J goBack"
          "map K goForward"
          "map <c-H> moveTabLeft"
          "map <c-L> moveTabRight"
        ];

        searchEngines = lib.concatStringsSep "\\n" [
          "w: https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s Wikipedia"
          "d: https://www.duckduckgo.com/search?q=%s DuckDuckGo"
          "g: https://www.google.com/search?q=%s Google"
          "y: https://www.youtube.com/results?search_query=%s Youtube"
          "gm: https://www.google.com/maps?q=%s Google Maps"
          "nxp: https://search.nixos.org/packages?channel=unstable&query=%s NixOS Packages"
          "nxo: https://search.nixos.org/options?channel=unstable&query=%s NixOS Options"
          "hmo: https://home-manager-options.extranix.com/?query=%s&release=master Home Manager Options"
        ];
      in
      ''
        {
          "keyMappings": "${keyMappings}",
          "newTabUrl": "https://this-page-intentionally-left-blank.org/",
          "grabBackFocus": true,
          "searchEngines": "${searchEngines}",
          "settingsVersion": "2.3.1",
          "exclusionRules": [
            {
              "passKeys": "",
              "pattern": "https?://cad.onshape.com/*"
            }
          ]
        }
      '';
  };

  den.aspects.firefox-niri.homeManager.programs.niri.settings.binds = {
    "Mod+B".action.spawn = "firefox";
  };
}
