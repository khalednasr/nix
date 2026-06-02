{ inputs, config, ... }:
let
  stateVersion = "26.05";
in
{
  config.flake.nixosConfigurations = builtins.mapAttrs (
    hostName: host:
    let
      getNixosModules = aspect: map (aspect: aspect.nixos) aspect.resolvedAspects;

      hostNixosModules = getNixosModules host;
      userNixosModules = builtins.concatMap (user: getNixosModules user) host.resolvedUsers;
      nixosModules = hostNixosModules ++ userNixosModules;

      gethomeManagerModules = aspect: map (aspect: aspect.homeManager) aspect.resolvedAspects;
      hostHomeManagerModules = gethomeManagerModules host;

      extraConfig = {
        networking.hostName = hostName;
        system.stateVersion = stateVersion;

        nixpkgs.config.allowUnfree = true;

        users.users = builtins.listToAttrs (
          map (user: {
            name = user.aspectName;
            value = {
              isNormalUser = true;
            };
          }) host.resolvedUsers
        );


        imports = [ host.homeManagerNixosModule ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users = builtins.listToAttrs (
          map (user: {
            name = user.aspectName;
            value = {
              imports = hostHomeManagerModules ++ (gethomeManagerModules user);
              home.stateVersion = stateVersion;
            };
          }) host.resolvedUsers
        );
      };
    in
    host.instantiate {
      modules = nixosModules ++ [ extraConfig ];
    }
  ) config.flake.hosts;
}
