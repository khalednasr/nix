{
  aspects.windows = {
    homeManager =
      { config, pkgs, ... }:
      {
        services.podman.enable = true;

        services.podman.containers.windows = {
          image = "ghcr.io/dockur/windows:latest";
          autoStart = false;

          environment = {
            VERSION = "11";
            RAM_SIZE = "6G";
            CPU_CORES = "6";
            DISK_SIZE = "128G";
            KEYBOARD = "de-DE";
            NETWORK = "user";
          };

          ports = [
            "127.0.0.1:8006:8006"
            "127.0.0.1:3389:3389/tcp"
            "127.0.0.1:3389:3389/udp"
          ];

          volumes = [
            "${config.home.homeDirectory}/.local/share/windows:/storage"
            "${config.home.homeDirectory}/windows:/shared"
          ];

          devices = [
            "/dev/kvm:/dev/kvm"
            "/dev/net/tun:/dev/net/tun"
          ];

          addCapabilities = [ "CAP_NET_ADMIN" ];

          extraPodmanArgs = [
            "--stop-timeout=10"
          ];
        };

        home.packages = [ pkgs.remmina ];

        home.file.".local/share/windows/windows.remmina" = {
          force = true;
          text = ''
            [remmina]
              name=windows
              server=localhost
              protocol=RDP
              username=docker
              password=WXzp7aXBtng=
              sound=local
              resolution_mode=2
              quality=9
              viewmode=4
          '';
        };
      };

    provides.niri.homeManager = {
      programs.niri.settings = {
        binds = {
          "Mod+X" = {
            action.spawn-sh = ''
              systemctl --user start podman-windows.service
              remmina -c ~/.local/share/windows/windows.remmina
            '';
          };

          "Mod+Shift+X" = {
            action.spawn-sh = ''
              systemctl --user stop podman-windows.service
            '';
          };
        };
      };
    };
  };
}
