{
  perSystem =
    { pkgs, ... }:
    {
      devShells.python = pkgs.mkShell {
        packages =
          let
            python = pkgs.python314;
            pp = pkgs.python314Packages;
          in
          [
            python
            pp.pip
            pp.numpy
            pp.pandas
            pp.scipy
            pp.jupyter
            pp.matplotlib
            pp.seaborn
            pp.scikit-learn
            pp.requests
          ];

        shellHook = ''
          rm -rf /tmp/tmp-venv
          python -m venv /tmp/tmp-venv
          source /tmp/tmp-venv/bin/activate
        '';
      };

      devShells.rust = pkgs.mkShell {
        packages = with pkgs; [
          cargo
          rustc
          rustfmt
          clippy
        ];
      };

      devShells.cpp = pkgs.mkShell {
        packages = with pkgs; [
          libgcc
          gnumake
          cmake
        ];
      };
    };
}
