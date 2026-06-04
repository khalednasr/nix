{
  aspects.numerino.nixos =
    { config, ... }:
    {
      services.syncthing = {
        enable = true;
        user = "syncthing";
        group = "syncthing";
        configDir = "/data/state/syncthing";
        dataDir = "/data/syncthing";
        cert = config.age.secrets.syncthing-cert.path;
        key = config.age.secrets.syncthing-key.path;
        guiAddress = "0.0.0.0:8384";
        openDefaultPorts = true;
        overrideDevices = false;
        overrideFolders = false;
        settings.options = {
          natEnabled = false;
          globalAnnounceEnabled = false;
          localAnnounceEnabled = false;
          relaysEnabled = false;
          urAccepted = -1;
        };
      };

      users.users.syncthing.homeMode = "770";
      systemd.services.syncthing.serviceConfig.UMask = "0007";
    };
}
