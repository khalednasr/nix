{ inputs, config, ... }:
{
  aspects.numerino = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      tui
      niri
      noctalia
      adwaita-theme
      fuzzel
      kitty
      nemo
      vivaldi
      vimium
      brightness-control
      udiskie
      steam
      sunshine

      nvidia-intel-hybrid
    ];

    nixos =
      { pkgs, ... }:
      {
        hardware.nvidia.prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:2";
        };

        networking.interfaces.eno1.wakeOnLan.enable = true;
        networking.firewall.allowedUDPPorts = [ 9 ];

        virtualisation.docker.enable = true;
        virtualisation.oci-containers.backend = "docker";

        environment.systemPackages = [
          pkgs.vlc
        ];
      };

    provides.niri.homeManager = {
      programs.niri.settings.outputs = {
        "ASUSTek COMPUTER INC VG27A NCLMQS018692" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 143.972;
          };
          scale = 1.0;
        };
      };
    };
  };
}
