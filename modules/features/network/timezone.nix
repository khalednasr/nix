{
  den.aspects.timezone.nixos =
    { pkgs, ... }:
    {
      services.automatic-timezoned.enable = true;
    };
}
