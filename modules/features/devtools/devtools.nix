{ self, ... }:
let
  packages_from = pkgs: [
    self.packages.${pkgs.stdenv.hostPlatform.system}.fish
    self.packages.${pkgs.stdenv.hostPlatform.system}.git
    self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
  ];
in
{
  den.aspects.devtools = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = packages_from pkgs;
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = packages_from pkgs;
      };
  };
}
