{ lib, den, ... }:
{
  den.ctx.user.includes = [ den._.mutual-provider ];

  den.default.nixos.system.stateVersion = "25.11";

  den.default.homeManager.home.stateVersion = "25.11";

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default.nixos.home-manager.backupCommand = "rm";
}
