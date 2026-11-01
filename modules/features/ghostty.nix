{inputs, ...}: {
  aspects.ghostty = {
    homeManager =
      { pkgs, ... }:
      {
        home.sessionVariables.TERMINAL = "ghostty";

        fonts.fontconfig.enable = true;

        home.packages = with pkgs; [
          maple-mono.truetype
          maple-mono.NF-unhinted
          maple-mono.NF-CN-unhinted
        ];

        programs.ghostty = {
          enable = true;
          package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ghostty;
          settings = {
            title = ''" "'';
            font-size = 11;
            font-family = "Maple Mono";
            confirm-close-surface = false;
            shell-integration-features = "ssh-env,ssh-terminfo";
            quick-terminal-position = "center";
            quick-terminal-size = "66%,66%";
            quick-terminal-animation-duration = 0.3;
          };
        };
      };

    provides.umbriel.homeManager = { config, ... }: {
      programs.umbriel.settings.keybinds = {
        "Mod+A" = "spawn ghostty +toggle-quick-terminal";
      };
    };
  };
}
