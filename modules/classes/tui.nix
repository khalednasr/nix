{ config, ... }:
{
  aspects.tui = {
    includes = with config.flake.aspects; [
      nix-settings
      nix-ld
      agenix
      ssh
      avahi
      tailscale
      wireguard
      firewall
      timezone
      devtools
      chrt
    ];
  };
}
