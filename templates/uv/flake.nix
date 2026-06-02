{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    gui-deps.url = "github:khalednasr/gui-deps";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          devShells.default =
            with pkgs;
            mkShell {
              packages = [
                uv
              ];

              LD_LIBRARY_PATH = inputs.gui-deps.makeLibraryPathFrom pkgs;

              shellHook = ''
                if [ ! -f ./.venv/bin/activate ]; then
                  uv sync
                fi
                source ./.venv/bin/activate
              '';
            };
        };

    };
}
