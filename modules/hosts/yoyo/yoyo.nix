{ inputs, config, ... }:
{
  aspects.yoyo = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      gui
      steam
      orcaslicer

      nvidia-amd-hybrid
      power-management
    ];

    nixos = {
      hardware.nvidia.prime = {
        amdgpuBusId = "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      services.logind.settings.Login = {
        HandleLidSwitch = "poweroff";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };

    provides.niri.homeManager = {
      programs.niri.settings.outputs = {
        "California Institute of Technology 0x1410 Unknown" = {
          mode = {
            width = 3072;
            height = 1920;
            refresh = 120.002;
          };
          scale = 1.75;
        };
        "ASUSTek COMPUTER INC VG27A NCLMQS018692" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 144.006;
          };
          scale = 1.0;
        };
      };
    };
  };
}
