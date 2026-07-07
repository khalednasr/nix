{ inputs, config, ... }:
{
  aspects.toobig = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      gui
      nvidia
      steam
    ];

    nixos =
      { pkgs, ... }:
      {
        users.groups.data = { };
        users.users.nasrk.extraGroups = [ "data" ];

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
