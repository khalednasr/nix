{
  den.aspects.firewall.nixos =
    { pkgs, ... }:
    {
      networking.firewall.enable = true;
    };
}
