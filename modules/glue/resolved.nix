{ config, lib, ... }:
let
  resolve =
    unresolvedAspect:
    let
      nameAsList = aspect: (if aspect.aspectName != "" then [ aspect.aspectName ] else [ ]);

      getNames =
        aspect:
        if aspect.includes != [ ] then
          ((builtins.concatMap getNames aspect.includes) ++ (nameAsList aspect))
        else
          (nameAsList aspect);

      namesFromIncludes = getNames unresolvedAspect;

      aspectsFromIncludes = map (name: config.flake.aspects.${name}) namesFromIncludes;

      getRelevantProvides =
        fromAspect:
        (builtins.concatMap (
          toAspectName:
          (
            if (builtins.elem toAspectName namesFromIncludes) then
              [
                (
                  fromAspect.provides.${toAspectName} // { aspectName = "${fromAspect.aspectName}->${toAspectName}"; }
                )
              ]
            else
              [ ]
          )
        ) (builtins.attrNames fromAspect.provides));

      aspectsFromProvides = (
        builtins.concatMap (
          fromAspect: getRelevantProvides config.flake.aspects.${fromAspect.aspectName}
        ) aspectsFromIncludes
      );

      includedAspects = (aspectsFromIncludes ++ aspectsFromProvides);
    in
    includedAspects;
in
{
  config.flake.aspects = builtins.mapAttrs (
    name: value:
    value
    // {
      aspectName = name;
    }
  ) config.aspects;

  config.flake.resolvedAspects = builtins.mapAttrs (
    _: unresolvedAspect:
    let
      resolvedAspects = resolve unresolvedAspect;
      resolvedAspectNames = map (aspect: aspect.aspectName) resolvedAspects;
    in
    unresolvedAspect
    // {
      inherit resolvedAspects resolvedAspectNames;
    }
  ) config.flake.aspects;

  config.flake.hosts = builtins.mapAttrs (
    _: host:
    host
    // rec {
      resolvedUsers = map (user: config.flake.resolvedAspects.${user.aspectName}) host.users;
      resolvedUserNames = map (aspect: aspect.aspectName) resolvedUsers;
    }
  ) (lib.filterAttrs (_: aspect: aspect.type == "host") config.flake.resolvedAspects);

  config.flake.users = lib.filterAttrs (
    _: aspect: aspect.type == "user"
  ) config.flake.resolvedAspects;
}
