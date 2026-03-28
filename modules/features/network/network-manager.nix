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

    provides.to-users =
      { user, ... }:
      {
        nixos.users.users.${user}.extraGroups = [ "networkmanager" ];
      };
  };
}
