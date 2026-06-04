{
  aspects.server.nixos =
    { lib, ... }:
    let
      mkStringOption = default: lib.mkOption { inherit default; type = lib.types.str; };
    in
    {
      options.subnets = {
        admin = mkStringOption "100.64.1.0/24";
        shiru = mkStringOption "100.64.10.0/24";
        privateLab = mkStringOption "100.64.50.0/24";
        media = mkStringOption "100.64.90.0/24";
      };
    };
}
