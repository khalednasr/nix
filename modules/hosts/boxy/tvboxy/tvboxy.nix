{ inputs, config, ... }:
{
  aspects.tvboxy = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      microvm-guest
      tui
      steam
    ];

    nixos =
      { pkgs, ... }:
      {
        services.displayManager.sddm.enable = true;
        services.displayManager.autoLogin.enable = true;
        services.displayManager.autoLogin.user = "nasrk";

        services.desktopManager.plasma6.enable = true;
      };
  };
}
