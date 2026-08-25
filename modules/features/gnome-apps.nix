{
  aspects.gnome-apps = {
    nixos = {
      services.gvfs.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nemo
          file-roller
          nemo-fileroller
          papers
          loupe
        ];
      };
  };
}
