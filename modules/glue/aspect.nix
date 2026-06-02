{ lib, ... }:
with lib;
let
  mkStringOption =
    default:
    mkOption {
      inherit default;
      type = types.str;
    };

  mkDeferredModuleOption =
    default:
    mkOption {
      inherit default;
      type = types.deferredModule;
    };
in
{
  options.aspects = mkOption {
    type = types.lazyAttrsOf (
      types.submodule {
        options.aspectName = mkStringOption "";

        options.type = mkStringOption "generic";

        options.nixos = mkDeferredModuleOption { };

        options.homeManager = mkDeferredModuleOption { };

        options.includes = mkOption { default = [ ]; };

        options.provides = mkOption {
          type = types.lazyAttrsOf (
            types.submodule {
              options.aspectName = mkStringOption "";
              options.type = mkStringOption "generic";
              options.nixos = mkDeferredModuleOption { };
              options.homeManager = mkDeferredModuleOption { };
            }
          );
          default = { };
        };

        options.instantiate = mkOption {
          default = _: { };
        };

        options.homeManagerNixosModule = mkDeferredModuleOption { };

        options.users = mkOption { default = [ ]; };
      }
    );
  };
}
