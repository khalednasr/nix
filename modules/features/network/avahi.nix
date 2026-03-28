{
  den.aspects.avahi.nixos =
    { pkgs, ... }:
    {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
}
