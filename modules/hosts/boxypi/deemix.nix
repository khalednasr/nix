{
  aspects.boxypi.nixos =
    { lib, ... }:
    {
      users.users.deemix.uid = 991; 
      users.users.deemix.group = "media";

      virtualisation.oci-containers.containers.deemix = {
        image = "ghcr.io/bambanah/deemix:latest";
        ports = [ "6595:6595" ];
        volumes = [
          "/home/media/.config/deezer:/config"
          "/home/media/music:/downloads"
        ];
        environment = {
          PUID = "991";
          PGID = "979";
          UMASK_SET = "000";
        };
      };
    };
}
