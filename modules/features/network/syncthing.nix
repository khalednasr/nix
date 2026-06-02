{
  aspects.syncthing = {
    homeManager.services.syncthing = {
      enable = true;
    };

    nixos.networking.firewall.allowedTCPPorts = [
      8384
      22000
    ];

    nixos.networking.firewall.allowedUDPPorts = [
      22000
      21027
    ];
  };
}
