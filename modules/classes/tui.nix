{ config, ... }:
{
  aspects.tui = {
    includes = with config.flake.aspects; [
      nix-settings
      nix-ld
      agenix
      ssh
      network-manager
      avahi
      tailscale
      wireguard
      firewall
      timezone
      tuigreet
      devtools
      chrt
    ];
  };
}
