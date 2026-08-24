{ config, ... }:
{
  aspects.gui = {
    includes = with config.flake.aspects; [
      tui
      niri
      noctalia
      adwaita-theme
      kitty
      nemo
      vivaldi
      vimium
      syncthing
      social
      distrobox
      brightness-control
      bluetooth
      printing
      udiskie
      udev
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          kicad
          vscode
          caligula
          vlc
          remmina
          openvpn
          onlyoffice-desktopeditors
        ];

        home.sessionPath = [ "$HOME/.local/bin" ];
      };
  };
}
