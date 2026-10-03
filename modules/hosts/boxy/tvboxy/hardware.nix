{ config, ... }:
{
  aspects.boxy.nixos = {
    boot.kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=8086:4690,8086:7a88,8086:7ad0,8086:7aa3,8086:7aa4,8086:1a1c"
    ];

    boot.kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_iommu_type1"
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", GROUP="kvm"
    '';

    microvm.vms.tvboxy.autostart = false;
    microvm.vms.tvboxy.evaluatedConfig = config.flake.nixosConfigurations.tvboxy;
    systemd.services."microvm@tvboxy".serviceConfig.Restart = "no";

    services.logind.enable = true;
    services.logind.settings.Login.HandleSuspendKey = "ignore";

    services.keyd = {
      enable = true;

      keyboards.default = {
        ids = [ "1997:2433" ]; # air mouse
        settings.main.sleep = "command(systemctl start microvm@tvboxy.service)";
      };
    };
  };

  aspects.tvboxy.nixos = { pkgs, ... }: {
    nixpkgs.hostPlatform = "x86_64-linux";

    microvm.qemu.machine = "q35";
    microvm.vcpu = 6;
    microvm.mem = 8096;

    microvm.qemu.extraArgs = [ "-usb" ];

    microvm.devices = [
      {
        bus = "pci";
        path = "0000:00:02.0";
      }
      {
        bus = "pci";
        path = "0000:00:1f.3";
      }
      {
        bus = "usb";
        path = "vendorid=0x1997,productid=0x2433"; # airmouse
      }
      {
        bus = "usb";
        path = "vendorid=0x2357,productid=0x0604"; # bluetooth
      }
      {
        bus = "usb";
        path = "vendorid=0x28de,productid=0x1304"; # steam controller
      }
    ];

    microvm.volumes = [
      {
        image = "/state/vms/tvboxy.raw";
        mountPoint = "/";
        size = 131072;
      }
    ];

    hardware.firmware = [ pkgs.linux-firmware ];

    hardware.graphics = {
      enable = true;
      extraPackages = [ pkgs.vpl-gpu-rt ];
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
