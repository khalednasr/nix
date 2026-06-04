{
  aspects.server.nixos = {
    services.nzbhydra2 = {
      enable = true;
      dataDir = "/data/state/nzbhydra2";
    };
  };
}
