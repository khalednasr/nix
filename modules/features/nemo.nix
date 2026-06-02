{
  aspects.nemo = {
    nixos = {
      services.gvfs.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nemo
        ];
      };
  };
}
