{ den, ... }:
{
  den.aspects.steam = {
    includes = [
      (den.provides.unfree [ "steam" "steam-unwrapped" ])
    ];

    nixos =
      { lib, ... }:
      {
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
        };

        environment.variables = {
          # Containerize steam games to avoid polluting home folder with game config files
          PRESSURE_VESSEL_SHARE_HOME = 0;
        };
      };
  };
}
