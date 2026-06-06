{
  aspects.server.nixos = {
    virtualisation.oci-containers.containers.upsnap = {
      image = "ghcr.io/seriousm4x/upsnap:latest";
      extraOptions = [ "--network=host" ];
      capabilities.NET_RAW = true;
      volumes = [ "/data/state/upsnap:/app/pb_data" ];
    };
  };
}
