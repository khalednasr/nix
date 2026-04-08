{ inputs, self, ... }:
let
  name = "fish";

  customPackage =
    pkgs:
    let
      extraPackages = [
        pkgs.zoxide
        pkgs.fzf
        pkgs.direnv
        pkgs.starship
        self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
      ];

      fishConfig = pkgs.writeTextFile {
        name = "fish-config.fish";
        text = ''
          set fish_greeting

          set -x EDITOR nvim

          set -x DIRENV_CONFIG ${direnvConfigHome}
          direnv hook fish | source

          fzf --fish | source

          alias cd="z"
          zoxide init fish | source

          set -x STARSHIP_CONFIG ${starshipConfig}/starship.toml
          starship init fish | source

          ${yaziIntegration}
        '';
      };

      direnvConfig = pkgs.writeTextFile {
        name = "direnv.toml";
        text = ''
          [global]
          log_filter = "^$"
          log_format = "-"
          warn_timeout = "1800s"
        '';
      };

      direnvrc = pkgs.writeTextFile {
        name = "direnvrc";
        text = ''
          source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
        '';
      };

      direnvConfigHome = pkgs.runCommand "DIRENV_CONFIG_HOME" { } ''
        mkdir -p "$out"
        ln -s ${direnvConfig} $out/direnv.toml
        ln -s ${direnvrc} $out/direnvrc
      '';

      starshipConfig = pkgs.runCommand "STARSHIP_CONFIG" { } ''
        mkdir -p "$out"
        ${pkgs.starship}/bin/starship preset pure-preset -o $out/starship.toml
      '';

      yaziIntegration = ''
        function y
          set -l tmp (mktemp -t "yazi-cwd.XXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end
      '';
    in
    inputs.nix-wrapper-modules.lib.wrapPackage ({
      inherit pkgs;
      inherit extraPackages;
      package = pkgs.fish;
      passthru.shellPath = "/bin/fish";

      flags = {
        "--init-command" = "source ${fishConfig}";
      };
    });
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${name} = customPackage pkgs;
    };
}
