{
  den.aspects.brightness-control = {
    nixos =
      { pkgs, ... }:
      {
        hardware.i2c.enable = true;
        users.groups.i2c = { };

        environment.systemPackages = with pkgs; [
          ddcutil
          brightnessctl
        ];
      };
  };
}
