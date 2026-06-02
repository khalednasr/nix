{
  aspects.numerino.nixos =
    { config, ... }:
    {
      users.users.nemo = {
        isSystemUser = true;
        group = "media";
      };

      services.samba = with config.subnets; {
        enable = true;
        settings = {
          "global" = {
            "security" = "user";
          };

          "media" = {
            "path" = "/data/media";
            "browseable" = "yes";
            "read only" = "no";
            "hosts deny" = "0.0.0.0/0";
            "hosts allow" = "${admin} ${shiru}";
          };

          "sync" = {
            "path" = "/data/syncthing";
            "browseable" = "yes";
            "read only" = "no";
            "hosts deny" = "0.0.0.0/0";
            "hosts allow" = "${admin}";
          };

          "archive" = {
            "path" = "/data/archive";
            "browseable" = "yes";
            "read only" = "no";
            "hosts deny" = "0.0.0.0/0";
            "hosts allow" = "${admin}";
          };
        };
      };

      services.samba-wsdd.enable = true;
    };
}
