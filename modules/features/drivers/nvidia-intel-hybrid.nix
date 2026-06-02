{
  aspects.nvidia-intel-hybrid = {
    nixos =
      { config, ... }:
      {
        services.xserver.videoDrivers = [
          "modesetting"
          "nvidia"
        ];

        hardware.nvidia = {
          open = true;
          nvidiaSettings = false;
          package = config.boot.kernelPackages.nvidiaPackages.stable;

          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
          };
        };
      };
  };
}
