{
  aspects.server.nixos =
    { lib, config, ... }:
    {
      users.users.deemix = {
        isSystemUser = true;
        group = "media";
        uid = 941;
      };

      virtualisation.oci-containers.containers.deemix = {
        image = "ghcr.io/bambanah/deemix:latest";
        ports = [ "6595:6595" ];
        volumes = [
          "/data/state/deemix:/config"
          "/data/media/library/music:/downloads"
        ];
        environment = {
          PUID = builtins.toString config.users.users.deemix.uid;
          PGID = builtins.toString config.users.groups.media.gid;
          UMASK_SET = "000";
        };
      };
    };
}
