{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.tui

      den.aspects.kitty
      den.aspects.firefox

      den.aspects.niri
      den.aspects.kitty-niri
      den.aspects.firefox-niri
      den.aspects.noctalia
      den.aspects.noctalia-niri
      den.aspects.noctalia-kitty

      den.aspects.social

      den.aspects.distrobox
      den.aspects.quickemu

      den.aspects.brightness-control
      den.aspects.bluetooth
      den.aspects.printing
      den.aspects.udiskie
      den.aspects.udev
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          caligula
          vlc
        ];
      };
  };
}
