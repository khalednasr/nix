{ config, ... }:
{
  aspects.boxy.nixos = {
    boot.kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=8086:4690"
      "video=efifb:off"
      "modprobe.blacklist=i915,xe"
    ];

    boot.kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_iommu_type1"
    ];

    boot.blacklistedKernelModules = [
      "i915"
      "xe"
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c52b", GROUP="kvm"
      SUBSYSTEM=="usb", ATTR{idVendor}=="1532", ATTR{idProduct}=="0099", GROUP="kvm"
    '';

    networking.nat.externalInterface = "enp0s31f6";

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

    microvm.devices = [
      {
        bus = "pci";
        path = "0000:00:02.0";
        qemu.deviceExtraArgs = "x-igd-opregion=on";
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

    microvm.qemu.extraArgs = [
      "-usb"
      "-vga"
      "none"
    ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ vpl-gpu-rt ];
    };

    hardware.firmware = [
      pkgs.linux-firmware
    ];
  };
}
