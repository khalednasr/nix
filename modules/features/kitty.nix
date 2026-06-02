{ lib, ... }:
{
  aspects.kitty = {
    homeManager =
      { pkgs, ... }:
      {
        fonts.fontconfig.enable = true;
        home.packages = with pkgs; [
          maple-mono.truetype
          maple-mono.NF-unhinted
          maple-mono.NF-CN-unhinted
        ];

        programs.kitty = {
          enable = true;
          font.name = "Maple Mono";
          themeFile = "GruvboxMaterialDarkHard";

          settings = {
            confirm_os_window_close = 0;
            enabled_layouts = "fat:bias=80";
            wayland_titlebar_color = "background";
          };
        };

        home.file.".config/kitty/quick-access-terminal.conf".text = ''
          lines 40
          margin_left 200
          margin_right 200
        '';
      };

    provides.niri.homeManager = {
      programs.niri.settings.binds = {
        "Mod+T".action.spawn = "kitty";
        "Mod+Shift+T".action.spawn-sh = "NO_TMUX=1 kitty";
        "Mod+E".action.spawn-sh = "kitty -e fish -c yazi";
        "Mod+A".action.spawn-sh = "NO_TMUX=1 kitten quick-access-terminal";
      };
    };

    provides.fuzzel.homeManager = {
      programs.fuzzel.settings.main.terminal = "kitty -e";
    };
  };
}
