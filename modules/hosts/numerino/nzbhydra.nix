{
  aspects.numerino.nixos = {
    services.nzbhydra2 = {
      enable = true;
      dataDir = "/state/nzbhydra2";
    };
  };
}
