{
  aspects.server.nixos =
    { pkgs, config, ... }:
    {
      virtualisation.oci-containers.containers.aiostreams = {
        image = "ghcr.io/viren070/aiostreams:latest";
        volumes = [ "/state/aiostreams:/app/data" ];
        dependsOn = [ "glutun" ];
        extraOptions = [ "--network=container:glutun" ];
        environmentFiles = [ config.age.secrets.aiostreams-env.path ];
      };

      virtualisation.oci-containers.containers.nzbhydra = {
        image = "lscr.io/linuxserver/nzbhydra2:latest";
        volumes = [ "/state/nzbhydra:/config" ];
        dependsOn = [ "glutun" ];
        extraOptions = [ "--network=container:glutun" ];
      };

      virtualisation.oci-containers.containers.sabnzbd = {
        image = "lscr.io/linuxserver/sabnzbd:latest";
        environment.UMASK = "002";
        environment.PGID = builtins.toString config.users.groups.media.gid;
        volumes = [
          "/state/sabnzbd:/config"
          "/data/media/downloads:/downloads"
          "/data/media/.incomplete-downloads:/incomplete-downloads"
        ];
        dependsOn = [ "glutun" ];
        extraOptions = [ "--network=container:glutun" ];
      };

      virtualisation.oci-containers.containers.glutun.ports = [
        "3000:3000" # aiostreams
        "5076:5076" # nzbhydra
        "6336:6336" # sabnzbd
      ];
    };
}
