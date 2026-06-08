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
        "map f LinkHints.activateMode"
        "map F LinkHints.activateModeToOpenInNewTab"
      ];
    in
    {
      home.file."./.config/vimium/vimium-options.json".text =
        ''
          {
            "keyMappings": "${keyMappings}",
            "grabBackFocus": true,
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
