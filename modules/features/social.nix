{ den, ... }:
{
  den.aspects.social = {
    includes = [
      (den.provides.unfree [ "zoom" "discord"])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          zoom-us
          teams-for-linux
          signal-desktop
          discord
        ];
      };
  };
}
