{
  aspects.server.nixos =
    { pkgs, config, ... }:
    {
      virtualisation.oci-containers.containers.glutun = {
        image = "qmcgaw/gluetun:latest";
        capabilities.NET_ADMIN = true;
        devices = [ "/dev/net/tun:/dev/net/tun" ];
        environmentFiles = [ config.age.secrets.glutun-nordvpn-env.path ];
      };

      systemd.services.gluetun-connectivity-check = {
        serviceConfig = {
          Type = "oneshot";

          ExecStart = pkgs.writeShellScript "check-gluetun-connectivity" ''
            set -eu

            CONTAINER="glutun"

            if ! ${pkgs.docker}/bin/docker inspect "$CONTAINER" >/dev/null 2>&1; then
              echo "Container $CONTAINER does not exist"
              exit 0
            fi

            if ! ${pkgs.docker}/bin/docker inspect \
                --format '{{.State.Running}}' \
                "$CONTAINER" | ${pkgs.gnugrep}/bin/grep -q true; then
              echo "Container $CONTAINER is not running"
              exit 0
            fi

            if ! ${pkgs.docker}/bin/docker exec "$CONTAINER" \
                /bin/sh -c 'wget -q --timeout=10 --spider https://www.google.com'; then
              echo "Internet connectivity through Gluetun failed; restarting container"
              ${pkgs.systemd}/bin/systemctl restart docker-"$CONTAINER".service
            else
              echo "Gluetun internet connectivity OK"
            fi
          '';
        };
      };

      systemd.timers.gluetun-connectivity-check = {
        wantedBy = [ "timers.target" ];

        timerConfig = {
          OnBootSec = "1min";
          OnUnitActiveSec = "1min";
          Unit = "gluetun-connectivity-check.service";
        };
      };
    };
}
