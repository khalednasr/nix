{ lib, ... }:
{
  aspects.vimium.homeManager =
    { pkgs, ... }:
    let
      keyMappings = lib.concatStringsSep "\\n" [
        "unmapAll"
        "map j scrollDown"
        "map k scrollUp"
        "map l scrollLeft"
        "map h scrollRight"
        "map <c-d> scrollPageDown"
        "map <c-u> scrollPageUp"
        "map G scrollToBottom"
        "map gg scrollToTop"
        "map o Vomnibar.activate"
        "map b Vomnibar.activate"
        "map O Vomnibar.activateInNewTab"
        "map B Vomnibar.activateBookmarksInNewTab"
        "map f LinkHints.activateMode"
        "map F LinkHints.activateModeToOpenInNewTab"
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
    {
      home.file."./.config/vimium/vimium-options.json".text =
        ''
          {
            "keyMappings": "${keyMappings}",
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
}
