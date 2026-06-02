{
  aspects.yoyo.nixos = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        "global" = {
          "security" = "user";
        };

        "tims-calcium" = {
          "path" = "/home/nasrk/sync/tims-calcium/";
          "browseable" = "yes";
          "read only" = "no";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}
