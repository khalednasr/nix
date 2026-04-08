{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.tui
      den.aspects.niri
      den.aspects.kitty
      den.aspects.firefox
    ];
  };
}
