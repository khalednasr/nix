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
      windows
      orcaslicer
      power-management
      network-manager
    ];

    nixos = { pkgs, ... }: {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
      ];

      boot.kernelPackages = pkgs.linuxPackages_zen;

      services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };

    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.stremio-linux-shell
      ];
    };

    provides.umbriel.homeManager = {
      programs.umbriel.settings.output = {
        "California Institute of Technology 0x1410 Unknown" = {
          mode = "3072x1920@120";
          scale = 1.75;
        };
        "ASUSTek COMPUTER INC VG27A NCLMQS018692" = {
          mode = "2560x1440@144";
          scale = 1.0;
        };
      };
    };
  };
}
