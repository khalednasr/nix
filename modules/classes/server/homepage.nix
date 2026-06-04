{
  aspects.server.nixos =
    { config, ... }:
    {
      services.homepage-dashboard = {
        enable = true;
        allowedHosts = "*";
        environmentFiles = [ config.age.secrets.homepage-env.path ];
        widgets = [
          {
            search = {
              provider = "google";
              target = "_self";
              showSearchSuggestions = true;
            };
          }
        ];
        settings.layout = [
          {
            Music = {
              style = "row";
              columns = 1;
            };
          }
          {
            Files = {
              style = "row";
              columns = 1;
            };
          }
          {
            Media = {
              style = "row";
              columns = 3;
            };
          }
        ];
        services = [
          {
            "Music" = [
              {
                "Navidrome" = {
                  widget.type = "navidrome";
                  icon = "navidrome.png";
                  href = "https://navidrome.nasrk.com";
                  widget.url = "https://navidrome.nasrk.com";
                  widget.user = "{{HOMEPAGE_VAR_NAVIDROME_USER}}";
                  widget.token = "{{HOMEPAGE_VAR_NAVIDROME_TOKEN}}";
                  widget.salt = "{{HOMEPAGE_VAR_NAVIDROME_SALT}}";
                };
              }
              {
                "Deemix" = {
                  icon = "deemix.png";
                  href = "https://deemix.nasrk.com";
                };
              }
            ];
          }
          {
            "Media" = [
              {
                "Jellyfin" = {
                  widget.type = "jellyfin";
                  icon = "jellyfin.png";
                  href = "https://jellyfin.nasrk.com";
                  widget.url = "https://jellyfin.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
                  enableQueue = true;
                };
              }
              {
                "Seerr" = {
                  widget.type = "seerr";
                  icon = "seerr.png";
                  href = "https://seerr.nasrk.com";
                  widget.url = "https://seerr.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_SEERR_KEY}}";
                  enableQueue = true;
                };
              }
              {
                "Prowlarr" = {
                  widget.type = "prowlarr";
                  icon = "prowlarr.png";
                  href = "https://prowlarr.nasrk.com";
                  widget.url = "https://prowlarr.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_PROWLARR_KEY}}";
                  enableQueue = true;
                };
              }
              {
                "Sonarr" = {
                  widget.type = "sonarr";
                  icon = "sonarr.png";
                  href = "https://sonarr.nasrk.com";
                  widget.url = "https://sonarr.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_SONARR_KEY}}";
                  enableQueue = true;
                };
              }
              {
                "Radarr" = {
                  widget.type = "radarr";
                  icon = "radarr.png";
                  href = "https://radarr.nasrk.com";
                  widget.url = "https://radarr.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_RADARR_KEY}}";
                  enableQueue = true;
                };
              }
              {
                "Bazarr" = {
                  widget.type = "bazarr";
                  icon = "bazarr.png";
                  href = "https://bazarr.nasrk.com";
                  widget.url = "https://bazarr.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_BAZARR_KEY}}";
                  enableQueue = true;
                };
              }
            ];
          }
          {
            "Files" = [
              {
                "Syncthing" = {
                  icon = "syncthing.png";
                  href = "https://syncthing.nasrk.com";
                };
              }
              {
                "Hydra" = {
                  icon = "nzbhydra2.png";
                  href = "https://hydra.nasrk.com";
                };
              }
              {
                "SABnzbd" = {
                  widget.type = "sabnzbd";
                  icon = "sabnzbd.png";
                  href = "https://sabnzbd.nasrk.com";
                  widget.url = "https://sabnzbd.nasrk.com";
                  widget.key = "{{HOMEPAGE_VAR_SABNZBD_KEY}}";
                  widget.rate = true;
                  widget.queue = true;
                };
              }
            ];
          }
        ];
      };
    };
}
