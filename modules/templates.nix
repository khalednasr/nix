{
  flake.templates =
    let
      templates = builtins.attrNames (builtins.readDir ../templates);
    in
    builtins.listToAttrs (
      map (template: {
        name = template;
        value = {
          description = template;
          path = ../templates/${template};
        };
      }) templates
    );
}
