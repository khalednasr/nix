{ config, inputs, lib, ... }:
{
  flake-file.inputs = {
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  aspects.boxypi = {
    type = "host";
    instantiate = inputs.nixos-raspberrypi.lib.nixosSystem;
    homeManagerNixosModule = inputs.home-manager.nixosModules.home-manager;

    users = with config.flake.aspects; [ nasrk ];

    includes = with config.flake.aspects; [
      tui
    ];

    nixos = {
      services.getty.autologinUser = "nasrk";
      environment.sessionVariables.NO_TMUX = "1";

      virtualisation.docker.enable = true;
      virtualisation.oci-containers.backend = "docker";

      users = {
        mutableUsers = true;
        users.root.initialHashedPassword = "$y$j9T$EBGJZhKc1UEufVIlCnPUx0$oJ9sUx4pYh4UjCxnf2ezrkjvMibRKT4XD7UibTIBJCA";

        users.nasrk = {
          initialHashedPassword = "$y$j9T$48ADycPVIa7.VrgKUoEap/$AS/EgZiDP0Z3tpJ1n2So.Zc/Feo27uLS/pcgNoFfYd6";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjlItsgRUqtjOPx9iKN5JDo/EbOAyjAD1Mfu8F11GJY shirin-pc"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDJMr+mNjSsThLfhKY5JPUn8YHwErCf8LC9pczIqKL6Q shirinch@Shirins-MacBook-Air.local"
          ];
        };

        groups.media.gid = lib.mkForce 979;
      };
    };
  };
}
