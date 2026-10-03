{
  aspects.server.nixos =
    { lib, config, ... }:
    {
      virtualisation.oci-containers.containers.aiostreams = {
        image = "ghcr.io/viren070/aiostreams:latest";
        volumes = [ "/state/aiostreams:/app/data" ];
        dependsOn = [ "aiostreams-glutun" ];
        extraOptions = [ "--network=container:aiostreams-glutun" ];
        environmentFiles = [ config.age.secrets.aiostreams-env.path ];
      };

      virtualisation.oci-containers.containers.aiostreams-glutun = {
        image = "qmcgaw/gluetun:latest";
        capabilities.NET_ADMIN = true;
        devices = [ "/dev/net/tun:/dev/net/tun" ];
        ports = [ "3000:3000" ];
        environmentFiles = [ config.age.secrets.glutun-nordvpn-env.path ];
      };
    };
}
