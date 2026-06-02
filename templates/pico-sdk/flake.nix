{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
        let
          pico-sdk-full = (pkgs.pico-sdk.override { withSubmodules = true; });
        in
        {
          devShells.default =
            with pkgs;
            mkShell {
              packages = [
                libgcc
                gcc-arm-embedded
                gnumake
                cmake
                pico-sdk-full
                picotool
                python313
                probe-rs-tools
              ];

              PICO_SDK_PATH = "${pico-sdk-full}/lib/pico-sdk";
            };
        };
    };
}
