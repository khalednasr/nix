{ inputs, ... }:
let
  domainName = "nasrk.com";

  mediaDir = "/home/media";
  stateDir = "/nixarr";
in
{
  flake-file.inputs.nixarr.url = "github:nix-media-server/nixarr";

  aspects.boxypi = {
    nixos =
      { pkgs, lib, config, ... }:
      {
        imports = [ inputs.nixarr.nixosModules.default ];

        services.caddy = {
          enable = true;
          environmentFile = config.age.secrets.caddy-env.path;
          package = pkgs.caddy.withPlugins {
            plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
            hash = "sha256-VHm9POg2KixGsMsAcfFFDMK9x6niRJ1iJV9kkSwkSjc=";
          };

          virtualHosts = {
            "*.${domainName}".extraConfig = ''
              tls {
                dns cloudflare {$CLOUDFLARE_API_KEY}
              }
            '';
            "sabnzbd.${domainName}".extraConfig = "reverse_proxy localhost:6336";
            "sonarr.${domainName}".extraConfig = "reverse_proxy localhost:8989";
            "radarr.${domainName}".extraConfig = "reverse_proxy localhost:7878";
            "bazarr.${domainName}".extraConfig = "reverse_proxy localhost:6767";
            "seerr.${domainName}".extraConfig = "reverse_proxy localhost:5055";
            "jellyfin.${domainName}".extraConfig = "reverse_proxy localhost:8096";
            "navidrome.${domainName}".extraConfig = "reverse_proxy localhost:4533";
            "deemix.${domainName}".extraConfig = "reverse_proxy localhost:6595";
            "syncthing.${domainName}".extraConfig = ''
              @denied not remote_ip 100.64.1.0/24
              abort @denied
              reverse_proxy localhost:8384
            '';

            "stremthru.${domainName}".extraConfig = "reverse_proxy localhost:8454";
          };
        };

        nixarr = {
          enable = true;
          mediaDir = mediaDir;
          stateDir = stateDir;

          vpn = {
            enable = true;
            wgConf = config.age.secrets.wireguard-conf.path;
          };

          sabnzbd = {
            enable = true;
            vpn.enable = true;
            whitelistRanges = [
              "192.168.15.0/24"
              "100.64.0.0/10"
            ];
          };

          sonarr.enable = true;
          radarr.enable = true;
          bazarr.enable = true;
          seerr.enable = true;
          jellyfin.enable = true;
          jellyfin.openFirewall = true;
        };

        systemd.services.sonarr.serviceConfig.ProtectHome = lib.mkForce false;
        systemd.services.radarr.serviceConfig.ProtectHome = lib.mkForce false;
        systemd.services.bazarr.serviceConfig.ProtectHome = lib.mkForce false;
      };
  };
}
