{
  den.aspects.kitty.homeManager =
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

        keybindings = {
          # Window management
          "alt+n" = "new_os_window_with_cwd";
          "alt+w" = "new_window_with_cwd";
          "alt+q" = "close_window";

          # Window navigation
          "alt+h" = "neighboring_window left";
          "alt+l" = "neighboring_window right";
          "alt+k" = "neighboring_window top";
          "alt+j" = "neighboring_window bottom";

          # Window sizing
          "alt+r" = "start_resizing_window";

          # Tab management
          "alt+b" = "new_tab_with_cwd";

          # Tab navigation
          "alt+shift+l" = "next_tab";
          "alt+shift+h" = "previous_tab";
          "alt+1" = "goto_tab 1";
          "alt+2" = "goto_tab 2";
          "alt+3" = "goto_tab 3";
          "alt+4" = "goto_tab 4";
          "alt+5" = "goto_tab 5";
          "alt+6" = "goto_tab 6";
          "alt+7" = "goto_tab 7";
          "alt+8" = "goto_tab 8";
          "alt+9" = "goto_tab 9";

          # Scrollback
          "alt+f" = "search_scrollback";
          "alt+u" = "scroll_line_up";
          "alt+d" = "scroll_line_down";
          "alt+shift+u" = "scroll_page_up";
          "alt+shift+d" = "scroll_page_down";
        };
      };

      home.shellAliases = {
        "kssh" = "kitten ssh";
      };
    };

  den.aspects.niri.homeManager.programs.niri.settings.binds = {
    "Mod+T".action.spawn = "kitty";
  };
}
