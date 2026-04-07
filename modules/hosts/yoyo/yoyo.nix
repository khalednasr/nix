{ den, ... }:
{
  den.hosts.x86_64-linux.yoyo.users.nasrk = { };

  den.aspects.yoyo = {
    includes = [
      den.aspects.gui
    ];
  };
}
