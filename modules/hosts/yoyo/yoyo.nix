{ den, ... }:
{
  den.hosts.x86_64-linux.yoyo.users.nasrk = { };

  den.aspects.yoyo = {
    includes = [
      den.aspects.gui
      den.aspects.steam
      den.aspects.power-management
      den.aspects.orcaslicer
    ];

    provides.to-users = {
      includes = [
        den.aspects.gui
      ];
    };
  };

  den.aspects.niri.homeManager.programs.niri.settings.outputs = {
    "California Institute of Technology 0x1410 Unknown" = {
      mode = {
        width = 3072;
        height = 1920;
        refresh = 120.002;
      };
      scale = 1.75;
    };
  };
}
