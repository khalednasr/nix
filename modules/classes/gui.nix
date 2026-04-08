{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.tui

      den.aspects.niri
      den.aspects.noctalia
      den.aspects.noctalia-niri
      den.aspects.noctalia-kitty

      den.aspects.kitty
      den.aspects.firefox
      den.aspects.orcaslicer
      den.aspects.social

      den.aspects.brightness-control
      den.aspects.bluetooth
      den.aspects.printing
      den.aspects.udiskie
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
