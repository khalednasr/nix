{
  aspects.chrt.nixos =
    { pkgs, ... }:
    {
      security.wrappers.chrt = {
        source = "${pkgs.util-linux}/bin/chrt";
        owner = "root";
        group = "root";
        capabilities = "cap_sys_nice+ep";
      };
    };
}
