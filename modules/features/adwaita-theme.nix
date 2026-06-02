{
  aspects.adwaita-theme.homeManager =
    { pkgs, ... }:
    {
      dconf.enable = true;
      dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      dconf.settings."org/gnome/desktop/interface".gtk-theme = "Adwaita-dark";

      gtk = {
        enable = true;
        gtk4.theme = null;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
      };
    };
}
