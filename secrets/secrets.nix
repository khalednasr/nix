let
  keys = import ./keys.nix;

  numerino = [
    keys.admin
    keys.numerino.host
    keys.numerino.nasrk
  ];
in
{
  "numerino/wireguard-conf.age".publicKeys = numerino;
  "numerino/caddy-env.age".publicKeys = numerino;
  "numerino/syncthing-cert.age".publicKeys = numerino;
  "numerino/syncthing-key.age".publicKeys = numerino;
  "numerino/homepage-env.age".publicKeys = numerino;
}
