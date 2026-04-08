{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.tui
      den.aspects.niri
    ];
  };
}
