{
  aspects.tvboxy.nixos =
    { pkgs, ... }:
    {
      services.displayManager.sddm.enable = true;
      services.displayManager.autoLogin.enable = true;

      services.desktopManager.plasma6.enable = true;

      environment.systemPackages = with pkgs; [
        flex-launcher
        vacuum-tube
      ];
    };
}
