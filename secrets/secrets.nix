let
  keys = import ./keys.nix;

  boxy = [
    keys.admin
    keys.boxy.host
    keys.boxy.nasrk
  ];
in
{
  "boxy/wireguard-conf.age".publicKeys = boxy;
  "boxy/caddy-env.age".publicKeys = boxy;
  "boxy/syncthing-cert.age".publicKeys = boxy;
  "boxy/syncthing-key.age".publicKeys = boxy;
  "boxy/homepage-env.age".publicKeys = boxy;
}
