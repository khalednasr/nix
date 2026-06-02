{
  aspects.social = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          zoom-us
          teams-for-linux
          signal-desktop
          discord
        ];
      };
  };
}
