{
  aspects.boxypi.nixos =
    { lib, ... }:
    {
      services.navidrome = {
        enable = true;
        settings.Address = "0.0.0.0";
        user = "navidrome";
        group = "media";
        settings.MusicFolder = "/home/media/music";
      };

      systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce false;
    };
}
