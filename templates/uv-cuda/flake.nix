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
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          devShells.default =
            with pkgs;
            mkShell {
              packages = [
                uv
              ];

              LD_LIBRARY_PATH = inputs.gui-deps.makeLibraryPathWith pkgs [
                cudatoolkit
                cudaPackages.cudnn
                "/run/opengl-driver"
              ];

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
