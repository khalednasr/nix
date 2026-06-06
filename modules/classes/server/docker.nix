{
  aspects.server.nixos = {
    virtualisation.docker.enable = true;
    virtualisation.oci-containers.backend = "docker";
  };
}
