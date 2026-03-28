{ den, self, ... }:
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

          shell = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHL6+vtrOsjN4WC1PW+/eCBPmXSLUwjvtgakT22/hXk nasrk@yoyo"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOm0mlC0thnDtCGuUwyscbnbVMzQUd6b6pFtpEiTRdt3 nasrk@numerino"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+sDL0yYN9ZpprywzEe2FhEoVhxD29ufj4b5MYq5L/A nasrk@toobig"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsh8qoWRNPG1j6dY0bHzTiW/0c1kphmx+RgTLpGw59l"
          ];
        };

        console.keyMap = "de";
      };

  };
}
