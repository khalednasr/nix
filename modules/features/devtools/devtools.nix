{ self, ... }:
let
  packages_from = pkgs: [
    self.packages.${pkgs.stdenv.hostPlatform.system}.git
    self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
    self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
    self.packages.${pkgs.stdenv.hostPlatform.system}.tmux

    pkgs.tmuxp
    pkgs.zoxide
    pkgs.fzf
    pkgs.direnv
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
    pkgs.gh
    pkgs.rsyncy
    pkgs.nmap
  ];
in
{
  flake-file.inputs.nix-wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

  perSystem =
    { pkgs, ... }:
    {
      devShells.devtools = pkgs.mkShell { packages = packages_from pkgs; };

      packages.devtools = pkgs.symlinkJoin {
        name = "devtools";
        paths = packages_from pkgs;
      };
    };

  aspects.devtools = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = packages_from pkgs;
      };
  };
}
