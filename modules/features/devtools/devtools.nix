{ self, ... }:
let
  packages_from = pkgs: [
    self.packages.${pkgs.stdenv.hostPlatform.system}.fish
    self.packages.${pkgs.stdenv.hostPlatform.system}.git
    self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
    self.packages.${pkgs.stdenv.hostPlatform.system}.nvim

    pkgs.ripgrep
    pkgs.btop
    pkgs.ncdu
    pkgs.wget
    pkgs.curl
    pkgs.gnutar
    pkgs.zip
    pkgs.unzip
    pkgs._7zz
    pkgs.sshfs
    pkgs.usbutils
  ];
in
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.devtools = pkgs.mkShell { packages = packages_from pkgs; };

      packages.devtools = pkgs.symlinkJoin {
        name = "devtools";
        paths = packages_from pkgs;
      };
    };

  den.aspects.devtools = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.devtools];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.devtools];
      };
  };
}
