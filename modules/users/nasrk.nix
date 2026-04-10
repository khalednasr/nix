{ den, self, ... }:
let
  shell_from = pkgs: self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
in
{
  den.aspects.nasrk = {
    includes = [
      den.provides.primary-user
    ];

    nixos =
      { pkgs, ... }:
      {
        users.users.nasrk = {
          description = "Khaled Nasr";

          shell = shell_from pkgs;

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHL6+vtrOsjN4WC1PW+/eCBPmXSLUwjvtgakT22/hXk nasrk@yoyo"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOm0mlC0thnDtCGuUwyscbnbVMzQUd6b6pFtpEiTRdt3 nasrk@numerino"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+sDL0yYN9ZpprywzEe2FhEoVhxD29ufj4b5MYq5L/A nasrk@toobig"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsh8qoWRNPG1j6dY0bHzTiW/0c1kphmx+RgTLpGw59l"
          ];

          extraGroups = [ "networkmanager" "i2c" "plugdev" "docker" ];
        };

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
          npush = "cd ${repoDir}; git add --all; git commit -m 'update'; git push; cd -";
          npull = "cd ${repoDir}; git pull; cd -";
        };
      };
  };
}
