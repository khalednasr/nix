{ inputs, lib, ... }:
{
  flake-file.inputs.agenix.url = "github:ryantm/agenix";

  aspects.agenix.nixos =
    { pkgs, config, ... }:
    let
      secretsDir = ../../secrets/${config.networking.hostName};

      entries = builtins.readDir secretsDir;
      filenames = builtins.filter (name: entries.${name} == "regular") (builtins.attrNames entries);

      secrets =
        if builtins.pathExists secretsDir then
          (builtins.listToAttrs (
            builtins.map (filename: {
              name = lib.removeSuffix ".age" filename;
              value = {
                file = "${secretsDir}/${filename}";
              };
            }) filenames
          ))
        else
          { };
    in
    {
      imports = [
        inputs.agenix.nixosModules.default
      ];

      environment.systemPackages = [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      age.secrets = secrets;
    };
}
