{
  aspects.nvidia = {
    nixos =
      { config, ... }:
      {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          open = true;
          nvidiaSettings = false;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };
  };
}
