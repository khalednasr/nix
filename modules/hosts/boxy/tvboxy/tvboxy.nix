{ inputs, config, ... }:
{
  aspects.tvboxy = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    includes = with config.flake.aspects; [
      microvm-guest
      tui
      steam
    ];
  };
}
