{
  den.aspects.bluetooth.nixos = {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    system.activationScripts = {
      "unblock_bluetooth" = ''
        rfkill unblock bluetooth
      '';
    };
  };
}
