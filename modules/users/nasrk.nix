{ config, self, ... }:
let
  shell_from = pkgs: self.packages.${pkgs.stdenv.hostPlatform.system}.fish;

  keys = import ../../secrets/keys.nix;
in
{
  aspects.nasrk = {
    type = "user";

    nixos =
      { pkgs, ... }:
      {
        users.users.nasrk = {
          description = "Khaled Nasr";

          shell = shell_from pkgs;

          openssh.authorizedKeys.keys = with keys; [
            yoyo.nasrk
            boxy.nasrk
            phone.nasrk
          ];

          extraGroups = [
            "wheel"
            "networkmanager"
            "kvm"
            "i2c"
            "plugdev"
            "docker"
            "media"
          ];
        };

        nix.settings.trusted-users = [ "nasrk" ];

        console.keyMap = "de";
      };

    homeManager =
      { pkgs, ... }:
      let
        repoDir = "/home/nasrk/nix";
      in
      {
        programs.fish.enable = true;
        programs.fish.package = shell_from pkgs;

        home.shellAliases = {
          nec = "cd ${repoDir} && nvim; cd -";
          nrf = "cd ${repoDir} && nix run .#write-flake; cd -";
          nrb = "sudo nixos-rebuild switch --flake ${repoDir}";
          ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d";

          nstatus = "cd ${repoDir}; git status; cd -";
          npull = "cd ${repoDir}; git pull; cd -";

          ssh-edit = "nvim ~/.ssh/config";
        };

        programs.fish.functions = {
          ndev.body = "nix develop ${repoDir}#$argv -c fish";
          ninit.body = ''
            nix flake init -t ${repoDir}#$argv
          '';
        };
      };
  };
}
