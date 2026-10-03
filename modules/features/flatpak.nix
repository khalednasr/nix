{ inputs, ... }: {
  flake-file.inputs = {
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
  };

  aspects.flatpak = {
    nixos = {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

      services.flatpak.enable = true;
    };

    homeManager = {
      imports = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];
    };
  };
}
