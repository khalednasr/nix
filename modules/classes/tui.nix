{ den, ... }:
{
  den.aspects.tui = {
    includes = [
      den.provides.hostname
      den.aspects.nix-settings
      den.aspects.nix-ld

      den.aspects.ssh
      den.aspects.network-manager
      den.aspects.avahi
      den.aspects.tailscale
      den.aspects.wireguard
      den.aspects.firewall
      den.aspects.timezone
      den.aspects.syncthing
      den.aspects.tuigreet

      den.aspects.devtools
    ];
  };
}
