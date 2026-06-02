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

    provides.niri.nixos = {
      boot.extraModprobeConfig = ''
        options nvidia_drm modeset=1
        options nvidia NVreg_EnableGpuFirmware=1
        options nvidia NVreg_PreserveVideoMemoryAllocations=1
        options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerDefault=0x1; PowerMizerDefaultAC=0x1; PerfLevelSrc=0x2222"
      '';

      environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
        ''
          {
            "rules": [
              {
                "pattern": {
                  "feature": "procname",
                  "matches": "niri"
                },
                "profile": "Limit Free Buffer Pool On Wayland Compositors"
              }
            ],
            "profiles": [
              {
                "name": "Limit Free Buffer Pool On Wayland Compositors",
                "settings": [
                  {
                    "key": "GLVidHeapReuseRatio",
                    "value": 0
                  }
                ]
              }
            ]
          }
        '';
    };
  };
}
