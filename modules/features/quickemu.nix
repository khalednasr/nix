{
  den.aspects.quickemu.nixos =
    { pkgs, ... }:
    {
      virtualisation.spiceUSBRedirection.enable = true;

      environment.systemPackages = with pkgs; [
        quickemu
      ];
    };
}
