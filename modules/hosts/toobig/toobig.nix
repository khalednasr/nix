{ inputs, config, ... }:
{
  aspects.toobig = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [
      nasrk
      vincent
    ];

    includes = with config.flake.aspects; [
      gui
      nvidia
      steam
    ];

    nixos =
      { pkgs, config, ... }:
      {
        users.groups.data = { };
        users.users.nasrk.extraGroups = [ "data" ];

        networking = {
          firewall.extraCommands = ''
            iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
          '';

          networkmanager.ensureProfiles.profiles.TIMSNet = {
            connection = {
              id = "TIMSNet";
              type = "ethernet";
              interface-name = "enp36s0f0";
            };

            ipv4 = {
              address1 = "192.168.5.2/24";
              method = "manual";
            };
          };
        };

        environment.systemPackages = with pkgs; [
          kicad
          prusa-slicer
        ];
      };

    provides.niri.homeManager = {
      programs.niri.settings.outputs = {
        "Dell Inc. DELL S2721QSA 45QKZY3" = {
          mode = {
            width = 3840;
            height = 2160;
            refresh = 59.997;
          };
          scale = 1.5;
        };
      };
    };
  };
}
