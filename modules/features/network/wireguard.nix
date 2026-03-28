{
  den.aspects.wireguard.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wireguard-tools
      ];

      networking.firewall.checkReversePath = "loose";
    };
}
