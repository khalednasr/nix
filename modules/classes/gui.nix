{ config, ... }:
{
  aspects.gui = {
    includes = with config.flake.aspects; [
      tui
      umbriel
      noctalia
      adwaita-theme
      gnome-apps
      ghostty
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
      flatpak
      waydroid
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
