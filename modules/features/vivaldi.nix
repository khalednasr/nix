{
  aspects.vivaldi.homeManager =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.vivaldi;
      };
    };

  aspects.vivaldi.provides.niri.homeManager = {
    programs.niri.settings.binds = {
      "Mod+B".action.spawn = "vivaldi";
    };
  };
}
