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

      den.aspects.brightness-control
      den.aspects.bluetooth
    ];
  };
}
