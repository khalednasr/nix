{ self, ... }:
let
  keys = import ../../../secrets/keys.nix;

  shell_from = pkgs: self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
in
{
  aspects.vincent = {
    type = "user";

    nixos =
      { pkgs, ... }:
      {
        users.users.vincent = {
          shell = shell_from pkgs;

          openssh.authorizedKeys.keys = with keys; [
            yoyo.nasrk
            phone.nasrk
            toobig.nasrk
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxv7ijeoxx+/5swAvogj0Ddf2bQSrHPdoxx3t0/zY9W"
          ];

          extraGroups = [
            "data"
          ];
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        programs.fish.package = shell_from pkgs;
        programs.direnv.enable = true;
        programs.direnv.nix-direnv.enable = true;
        programs.direnv.silent = true;
        programs.direnv.enableFishIntegration = true;

        home.packages = with pkgs; [
          git
          yazi
          neovim
          tmux
          zoxide
          fzf
          ripgrep
          btop
          ncdu
          wget
          curl
          gnutar
          zip
          unzip
          _7zz
          sshfs
          gh
          rsyncy
        ];
      };
  };
}
