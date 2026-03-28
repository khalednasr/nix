{
  den.aspects.ssh.nixos =
    { pkgs, ... }:
    {
      services.openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
      };
    };
}
