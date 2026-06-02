let
  primaryUser = "nasrk";
in
{
  aspects.numerino.nixos =
    { lib, ... }:
    {
      users.groups = {
        media = {
          gid = lib.mkForce 984;
          members = [ primaryUser ];
        };

        syncthing = {
          gid = lib.mkForce 923;
          members = [ primaryUser ];
        };

        archive = {
          gid = lib.mkForce 913;
          members = [ primaryUser ];
        };
      };
    };
}
