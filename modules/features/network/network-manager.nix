{
  den.aspects.network-manager = {
    nixos =
      { pkgs, ... }:
      {
        networking.networkmanager = {
          enable = true;
          plugins = with pkgs; [
            networkmanager-openvpn
          ];
        };

        # For internet sharing
        networking.firewall.allowedUDPPorts = [
          53
          67
        ];
      };
  };
}
