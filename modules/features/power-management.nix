{
  den.aspects.power-management.nixos = {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
