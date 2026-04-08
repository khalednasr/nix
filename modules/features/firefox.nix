{
  den.aspects.firefox.homeManager = {
    programs.firefox = {
      enable = true;
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
          "langpack-de@firefox.mozilla.org" = {
            # German
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/deutsch-de-language-pack/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
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
            "browser.startup.homepage" = "https://this-page-intentionally-left-blank.org/";

            # Bookmarks bar
            "browser.toolbars.bookmarks.visibility" = "never";

            # Theme
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.theme.content-theme" = 0;
            "browser.theme.toolbar-theme" = 0;
            "extensions.colorway-builtin-themes-cleanup" = 1;

            # Sidebar
            "sidebar.verticalTabs" = true;
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
            "sidebar.main.tools" = "syncedtabs,history,bookmarks";
            "sidebar.new-sidebar.has-used" = true;
            "sidebar.revamp" = true;
            "sidebar.visibility" = "expand-on-hover";
            "browser.toolbarbuttons.introduced.sidebar-button" = true;

            # Translation
            "browser.translations.automaticallyPopup" = false;

            # Disable AI chat
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.sidebar" = false;

            # UI state
            "browser.uiCustomization.state" =
              ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["ublock0_raymondhill_net-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","addon_darkreader_org-browser-action"],"nav-bar":["firefox-view-button","alltabs-button","stop-reload-button","back-button","forward-button","urlbar-container","vertical-spacer","downloads-button","unified-extensions-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","screenshot-button"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","unified-extensions-area","PersonalToolbar","toolbar-menubar"],"currentVersion":23,"newElementCount":4}'';
          };
        };
      };
    };

    home.file."./.config/vimium/vimium-options.json".text = ''
      {
        "keyMappings": "map K previousTab\nmap J nextTab",
        "newTabUrl": "https://this-page-intentionally-left-blank.org/",
        "grabBackFocus": true,
        "searchEngines": "w: https://www.wikipedia.org/w/index.php?title=Special:Search&search=%s Wikipedia\nd: https://www.duckduckgo.com/search?q=%s DuckDuckGo\ng: https://www.google.com/search?q=%s Google\ny: https://www.youtube.com/results?search_query=%s Youtube\ngm: https://www.google.com/maps?q=%s Google Maps\nnxp: https://search.nixos.org/packages?channel=unstable&query=%s NixOS Packages\nnxo: https://search.nixos.org/options?channel=unstable&query=%s NixOS Options\nhmo: https://home-manager-options.extranix.com/?query=%s&release=master Home Manager Options",
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

  den.aspects.niri.homeManager.programs.niri.settings.binds = {
    "Mod+B".action.spawn = "firefox";
  };
}
