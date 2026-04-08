{ inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.noctalia.homeManager =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia-shell = {
        enable = true;
      };
    };

  den.aspects.niri.homeManager.programs.niri.settings = {
    spawn-at-startup = [
      { argv = [ "noctalia-shell" ]; }
    ];
  };
}
