{ inputs, ... }:
let
  name = "git";

  customPackage =
    pkgs:
    inputs.nix-wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      settings = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        user.name = "khalednasr";
        user.email = "k.nasr92@gmail.com";
      };
    };
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${name} = customPackage pkgs;
    };
}
