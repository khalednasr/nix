let
  domainName = "nasrk.com";
in
{
  aspects.server.nixos =
    { config, pkgs, ... }:
    {
      services.caddy = {
        enable = true;
        environmentFile = config.age.secrets.caddy-env.path;
        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
          hash = "sha256-PWadA5qr/gR2qDcT8l8u1Xku7LM2HIfWTLOkzezCYy0=";
        };

        virtualHosts = with config.subnets; {
          "*.${domainName}".extraConfig = ''
            tls {
              dns cloudflare {$CLOUDFLARE_API_KEY}
            }
          '';
          "aiostreams.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:3000
          '';
          "sabnzbd.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:6336
          '';
          "deemix.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:6595
          '';
          "navidrome.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media} ${privateLab}
            abort @denied
            reverse_proxy localhost:4533
          '';
          "syncthing.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin}
            abort @denied
            reverse_proxy localhost:8384
          '';
          "hydra.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:5076
          '';
          "upsnap.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${steamdeck}
            abort @denied
            reverse_proxy localhost:8090
          '';
        };
      };
    };
}
