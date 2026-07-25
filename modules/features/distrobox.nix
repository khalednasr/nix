{
  aspects.distrobox.nixos =
    { pkgs, ... }:
    {
      virtualisation.docker.enable = true;
      environment.systemPackages = [ pkgs.distrobox ];
      environment.sessionVariables.DBX_CONTAINER_MANAGER = "docker";
    };
}
