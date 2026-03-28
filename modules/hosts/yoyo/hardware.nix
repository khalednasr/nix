{
  den.aspects.yoyo.nixos =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ohci_pci"
        "ehci_pci"
        "virtio_pci"
        "ahci"
        "usbhid"
        "sr_mod"
        "virtio_blk"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/dd26138f-aa75-4129-91ae-b19d020b597d";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/621B-AEC9";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [ ];
    };
}
