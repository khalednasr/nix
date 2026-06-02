let
  domainName = "nasrk.com";
in
{
  aspects.numerino.nixos =
    { config, pkgs, ... }:
    {
      services.caddy = {
        enable = true;
        environmentFile = config.age.secrets.caddy-env.path;
        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
          hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
        };

        virtualHosts = with config.subnets; {
          "*.${domainName}".extraConfig = ''
            tls {
              dns cloudflare {$CLOUDFLARE_API_KEY}
            }
          '';
          "home.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru}
            abort @denied
            reverse_proxy localhost:8082
          '';
          "sabnzbd.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:6336
          '';
          "prowlarr.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin}
            abort @denied
            reverse_proxy localhost:9696
          '';
          "sonarr.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:8989
          '';
          "radarr.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:7878
          '';
          "bazarr.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:6767
          '';
          "seerr.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:5055
          '';
          "jellyfin.${domainName}".extraConfig = ''
            @denied not remote_ip ${admin} ${shiru} ${media}
            abort @denied
            reverse_proxy localhost:8096
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
            @denied not remote_ip ${admin} ${shiru}
            abort @denied
            reverse_proxy localhost:5076
          '';
        };
      };
    };
}
