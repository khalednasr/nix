{
  aspects.toobig.nixos =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        loader.grub.enable = true;
        loader.grub.device = "nodev";
        loader.grub.useOSProber = true;
        loader.grub.efiSupport = true;
        loader.grub.fontSize = 42;
        loader.efi.canTouchEfiVariables = true;
        supportedFilesystems = [ "ntfs" ];
      };

      boot.initrd.availableKernelModules = [
        "xhci_pci_renesas"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/3eb8234c-7814-43f3-9e39-c0433c5a734f";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/AAD2-B212";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/ebbec77d-6357-4ddf-901a-57a983b20bcc";
        fsType = "ext4";
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
