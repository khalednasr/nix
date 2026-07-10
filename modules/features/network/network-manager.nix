{
  aspects.network-manager = {
    nixos =
      { pkgs, ... }:
      {
        networking.wireless.iwd.enable = true;

        networking.networkmanager = {
          enable = true;
          wifi.powersave = false;
          wifi.backend = "iwd";
        };

        # For internet sharing
        networking.firewall.allowedUDPPorts = [
          53
          67
        ];
      };
  };
}
