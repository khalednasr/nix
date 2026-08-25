{ config, ... }:
{
  aspects.gui = {
    includes = with config.flake.aspects; [
      tui
      niri
      noctalia
      adwaita-theme
      gnome-apps
      kitty
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
        ];

        home.sessionPath = [ "$HOME/.local/bin" ];
      };
  };
}
