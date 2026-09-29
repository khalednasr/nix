{ inputs, lib, ... }:
{
  flake-file.inputs = {
    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  aspects.microvm-host.nixos = {
    imports = [
      inputs.microvm.nixosModules.host
    ];

    networking.useNetworkd = true;

    systemd.network.netdevs."10-microvm".netdevConfig = {
      Kind = "bridge";
      Name = "microvm";
    };

    systemd.network.networks."10-microvm" = {
      matchConfig.Name = "microvm";
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      addresses = [
        {
          Address = "10.0.0.1/24";
        }
        {
          Address = "fd12:3456:789a::1/64";
        }
      ];
      ipv6Prefixes = [
        {
          Prefix = "fd12:3456:789a::/64";
        }
      ];
    };

    systemd.network.networks."11-microvm" = {
      matchConfig.Name = "vm-*";
      networkConfig.Bridge = "microvm";
    };

    # Allow inbound traffic for the DHCP server
    networking.firewall.allowedUDPPorts = [ 67 ];

    networking.nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = lib.mkDefault "eth0";
      internalInterfaces = [ "microvm" ];
    };
  };

  aspects.microvm-guest.nixos = {
    imports = [
      inputs.microvm.nixosModules.microvm
    ];

    systemd.network.enable = true;

    microvm = {
      interfaces = [
        {
          type = "tap";
          id = "vm-guest";
          mac = "02:00:00:00:00:01";
        }
      ];
    };
  };
}
