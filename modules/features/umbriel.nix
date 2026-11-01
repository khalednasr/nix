{ inputs, ... }:
{
  flake-file.inputs = {
    umbriel = {
      url = "github:noctalia-dev/umbriel";
    };
  };

  aspects.umbriel = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.umbriel.nixosModules.default ];
        programs.umbriel.enable = true;
      };

    homeManager =
      { pkgs, lib, config, ... }:
      {
        imports = [ inputs.umbriel.homeModules.default ];

        programs.umbriel = {
          enable = true;
          settings = {
            general.xwayland = true;
            general.xwayland_native_resolution = false;
            general.show_cheatsheet = false;

            appearance.title_bar.mode = "on";

            hot_corners.top_left = {
              enabled = true;
              action = "overview-open";
              delay_ms = 500;
            };

            input.keyboard = {
              repeat_delay = 300;
              repeat_rate = 30;
              numlock_toggle = true;
              layout = "de";
            };

            input.mouse.natural_scroll = true;

            input.cursor = {
              theme = "Bibata-Modern-Ice";
              size = 24;
              hide_when_typing = true;
              hide_timeout_ms = 5000;
            };

            layout = {
              gap = 10;
              extent_presets = [
                0.5
                0.667
              ];
              scrolling = {
                default_extent_fraction = 0.667;
                center_focused = "on_overflow";
              };
            };

            window_rule = [
              {
                opacity = 0.95;
                blur = true;
              }
            ];

            keybinds = {
              "Mod+T" = "spawn ${config.home.sessionVariables.TERMINAL}";
              "Mod+E" = "spawn ${config.home.sessionVariables.TERMINAL} -e fish -c yazi";

              "Mod+Q" = "window-close";

              "Mod+N" = "workspace-set-layout toggle scrolling dwindle";
              "Mod+M" = "workspace-set-layout stacking";

              "Mod+H" = "window-focus-or-output-left";
              "Mod+L" = "window-focus-or-output-right";
              "Mod+K" = "window-focus-or-workspace-up";
              "Mod+J" = "window-focus-or-workspace-down";

              "Mod+Ctrl+H" = "window-move-or-output-left";
              "Mod+Ctrl+L" = "window-move-or-output-right";
              "Mod+Ctrl+K" = "window-move-or-workspace-up";
              "Mod+Ctrl+J" = "window-move-or-workspace-down";

              "Mod+C" = "column-center";
              "Mod+R" = "window-cycle-primary-extent";

              "Mod+F" = "window-toggle-maximize";
              "Mod+Shift+F" = "window-toggle-fullscreen";
              "Mod+Plus" = "window-modify-width-right 0.1";
              "Mod+Minus" = "window-modify-width-right -0.1";
              "Mod+Shift+Plus" = "window-modify-width-right 0.1";
              "Mod+Shift+Minus" = "window-modify-width-right -0.1";

              "Mod+WheelUp" = "window-focus-or-output-left";
              "Mod+WheelDown" = "window-focus-or-output-right";
              "Mod+Shift+WheelUp" = "window-focus-or-workspace-up";
              "Mod+Shift+WheelDown" = "window-focus-or-workspace-down";
              "Mod+Ctrl+WheelUp" = "window-move-or-output-left";
              "Mod+Ctrl+WheelDown" = "window-move-or-output-right";
              "Mod+Ctrl+Shift+WheelUp" = "window-move-or-workspace-up";
              "Mod+Ctrl+Shift+WheelDown" = "window-move-or-workspace-down";

              "Mod+1" = "workspace-switch 1";
              "Mod+2" = "workspace-switch 2";
              "Mod+3" = "workspace-switch 3";
              "Mod+4" = "workspace-switch 4";
              "Mod+5" = "workspace-switch 5";
              "Mod+6" = "workspace-switch 6";
              "Mod+7" = "workspace-switch 7";
              "Mod+8" = "workspace-switch 8";
              "Mod+9" = "workspace-switch 9";

              "Mod+Ctrl+1" = "window-move-to-workspace 1";
              "Mod+Ctrl+2" = "window-move-to-workspace 2";
              "Mod+Ctrl+3" = "window-move-to-workspace 3";
              "Mod+Ctrl+4" = "window-move-to-workspace 4";
              "Mod+Ctrl+5" = "window-move-to-workspace 5";
              "Mod+Ctrl+6" = "window-move-to-workspace 6";
              "Mod+Ctrl+7" = "window-move-to-workspace 7";
              "Mod+Ctrl+8" = "window-move-to-workspace 8";
              "Mod+Ctrl+9" = "window-move-to-workspace 9";
            };
          };
        };

        home.packages = [
          pkgs.bibata-cursors
        ];
      };
  };
}
