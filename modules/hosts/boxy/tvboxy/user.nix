{ self, ... }:
let
  shell_from = pkgs: self.packages.${pkgs.stdenv.hostPlatform.system}.fish;

  keys = import ../../../../secrets/keys.nix;
in
{
  aspects.tvboxy.nixos =
    { pkgs, ... }:
    {
      services.displayManager.autoLogin.user = "nemo";

      users.users.nemo = {
        description = "Nemo";
        isNormalUser = true;

        shell = shell_from pkgs;

        initialHashedPassword = "$y$j9T$VczAOS46nBf5JPqbg7Gv21$48n1LAr08mMJSa8XvV4TxuNt/ghBHHpiJioj2iksO76";

        openssh.authorizedKeys.keys = with keys; [
          yoyo.nasrk
          boxy.nasrk
          phone.nasrk
        ];
      };

      console.keyMap = "de";
    };
}
