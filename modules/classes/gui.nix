{ config, ... }:
{
  aspects.gui = {
    includes = with config.flake.aspects; [
      tui
      niri
      noctalia
      adwaita-theme
      fuzzel
      kitty
      nemo
      vivaldi
      vimium
      syncthing
      social
      distrobox
      quickemu
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
          rustdesk
          caligula
          vlc
          remmina
          openvpn
          onlyoffice-desktopeditors
        ];
      };
  };
}
