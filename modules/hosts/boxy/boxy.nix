{ inputs, config, ... }:
{
  aspects.boxy = {
    type = "host";
    instantiate = inputs.nixpkgs.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      tui
      server
      niri
      fuzzel
      kitty
      nemo
      vivaldi
      vimium
      udiskie
    ];

    nixos =
      { pkgs, ... }:
      {
        hardware.graphics = {
          enable = true;
          extraPackages = with pkgs; [
            vpl-gpu-rt
          ];
        };
      };
  };
}
