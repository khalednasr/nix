{
  aspects.udev.nixos = {
    services.udev.extraRules = ''
      # Future Technology Devices International, Ltd FT2232C/D/H Dual UART/FIFO IC
      ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="666"

      # Microchip Technology, Inc. AX3 Composite Device 1.7
      ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="0057", MODE="666"

      # Microchip Technology, Inc. CWA Bootloader
      ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="003c", MODE="666"

      # STMicroelectronics STM Device in DFU Mode
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="666"

      # Raspberry Pi RP2 Boot
      ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="666"

      # Raspberry Pi Debugprobe on Pico (CMSIS-DAP)
      ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="666"
    '';
  };
}
