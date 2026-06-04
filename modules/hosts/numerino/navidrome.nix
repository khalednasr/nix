{
  aspects.numerino.nixos =
    { lib, config, ... }:
    {
      services.navidrome = {
        enable = true;
        settings.Address = "0.0.0.0";
        user = "navidrome";
        group = "media";
        settings.MusicFolder = "/data/media/library/music";
        settings.DataFolder = "/data/state/navidrome";
      };
    };
}
