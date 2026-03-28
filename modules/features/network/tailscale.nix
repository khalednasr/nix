{
  den.aspects.tailscale.nixos =
    { pkgs, ... }:
    {
      services.tailscale.enable = true;
    };
}
