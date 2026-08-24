{ inputs, ... }:
{
  flake-file.inputs.nixarr.url = "github:nix-media-server/nixarr";
  flake-file.inputs.nixarr.inputs.nixpkgs.follows = "nixpkgs";

  aspects.server.nixos =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nixarr.nixosModules.default ];

      nixarr = {
        enable = true;
        mediaDir = "/data/media";
        stateDir = "/data/state/nixarr";

        vpn = {
          enable = true;
          wgConf = config.age.secrets.wireguard-conf.path;
        };

        sabnzbd = {
          enable = true;
          vpn.enable = true;
          whitelistHostnames = [ "sabnzbd.nasrk.com" ];
          whitelistRanges = [
            "192.168.15.0/24"
            "100.64.0.0/10"
          ];
        };

        prowlarr.enable = true;
        bazarr.enable = true;
        sonarr.enable = true;
        radarr.enable = true;
        seerr.enable = true;
        jellyfin.enable = true;
      };

      services.prowlarr.settings.auth.required = "DisabledForLocalAddresses";
      services.sonarr.settings.auth.required = "DisabledForLocalAddresses";
      services.radarr.settings.auth.required = "DisabledForLocalAddresses";

      systemd.services.wg.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 60";
    };
}
