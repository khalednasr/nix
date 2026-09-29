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
      SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c52b", GROUP="kvm"
      SUBSYSTEM=="usb", ATTR{idVendor}=="1532", ATTR{idProduct}=="0099", GROUP="kvm"
    '';

    networking.nat.externalInterface = "enp0s20f0u1";

    microvm.autostart = [ "tvboxy" ];
    microvm.vms.tvboxy = {
      evaluatedConfig = config.flake.nixosConfigurations.tvboxy;
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
        path = "vendorid=0x046d,productid=0xc52b";
      }
      {
        bus = "usb";
        path = "vendorid=0x1532,productid=0x0099";
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
  };
}
