{ inputs, ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri = {
    homeManager =
      { pkgs, lib, ... }:
      let
        niri-pkg = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
      in
      {
        imports = [ inputs.niri.homeModules.niri ];
        programs.niri.package = niri-pkg;

        home.sessionVariables = {
          XDG_CURRENT_DESKTOP = "niri";
          QT_QPA_PLATFORM = "wayland;xcb";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          NIXOS_OZONE_WL = "1";
        };

        home.packages = [
          niri-pkg
          pkgs.wl-clipboard
          pkgs.wayland-utils
          pkgs.xwayland-satellite
          pkgs.bibata-cursors
        ];

        xdg.configFile."niri/config.kdl".text = ''
          include "nix-generated-config.kdl"
        '';

        xdg.configFile.niri-config.target = lib.mkForce "niri/nix-generated-config.kdl";

        programs.niri.settings = {
          input.keyboard = {
            repeat-delay = 300;
            repeat-rate = 30;
            numlock = true;
            xkb.layout = "de,eg";
          };

          input.focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "0%";
          };

          cursor = {
            theme = "Bibata-Modern-Ice";
            size = 24;
            hide-when-typing = true;
            hide-after-inactive-ms = 5000;
          };

          layout = {
            gaps = 16;
            center-focused-column = "on-overflow";
            always-center-single-column = true;
            default-column-width = {
              proportion = 0.67;
            };
            preset-column-widths = [
              { proportion = 0.5; }
              { proportion = 0.66667; }
            ];
            focus-ring.width = 4;
            shadow = {
              enable = true;
              softness = 30;
              spread = 5;
              offset = {
                x = 0;
                y = 5;
              };
            };
            background-color = "transparent";
          };

          prefer-no-csd = true;

          hotkey-overlay.skip-at-startup = true;

          window-rules = [
            {
              clip-to-geometry = true;
              draw-border-with-background = false;
              tiled-state = true;
              opacity = 0.94;
              geometry-corner-radius = {
                bottom-left = 10.0;
                bottom-right = 10.0;
                top-left = 10.0;
                top-right = 10.0;
              };
            }
          ];

          binds = {
            "Mod+Shift+Q".action.quit = [ ];
            "XF86AudioRaiseVolume" = {
              action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
              allow-when-locked = true;
            };
            "XF86AudioLowerVolume" = {
              action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
              allow-when-locked = true;
            };
            "XF86AudioMute" = {
              action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              allow-when-locked = true;
            };
            "XF86AudioMicMute" = {
              action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
              allow-when-locked = true;
            };
            "XF86AudioPlay" = {
              action.spawn-sh = "playerctl play-pause";
              allow-when-locked = true;
            };
            "XF86AudioStop" = {
              action.spawn-sh = "playerctl stop";
              allow-when-locked = true;
            };
            "XF86AudioPrev" = {
              action.spawn-sh = "playerctl previous";
              allow-when-locked = true;
            };
            "XF86AudioNext" = {
              action.spawn-sh = "playerctl next";
              allow-when-locked = true;
            };
            "Mod+O" = {
              action.toggle-overview = [ ];
              repeat = false;
            };
            "Mod+Q" = {
              action.close-window = [ ];
              repeat = false;
            };

            "Mod+Left".action.focus-column-left = [ ];
            "Mod+Down".action.focus-window-down = [ ];
            "Mod+Up".action.focus-window-up = [ ];
            "Mod+Right".action.focus-column-right = [ ];
            "Mod+H".action.focus-column-left = [ ];
            "Mod+L".action.focus-column-right = [ ];
            "Mod+J".action.focus-window-or-workspace-down = [ ];
            "Mod+K".action.focus-window-or-workspace-up = [ ];

            "Mod+Ctrl+Left".action.move-column-left = [ ];
            "Mod+Ctrl+Down".action.move-window-down = [ ];
            "Mod+Ctrl+Up".action.move-window-up = [ ];
            "Mod+Ctrl+Right".action.move-column-left = [ ];
            "Mod+Ctrl+H".action.move-column-left = [ ];
            "Mod+Ctrl+L".action.move-column-right = [ ];
            "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [ ];
            "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [ ];

            "Mod+Shift+Left".action.focus-monitor-left = [ ];
            "Mod+Shift+Down".action.focus-monitor-down = [ ];
            "Mod+Shift+Up".action.focus-monitor-up = [ ];
            "Mod+Shift+Right".action.focus-monitor-left = [ ];
            "Mod+Shift+J".action.focus-monitor-down = [ ];
            "Mod+Shift+K".action.focus-monitor-up = [ ];
            "Mod+Shift+L".action.focus-monitor-right = [ ];

            "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
            "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
            "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
            "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-left = [ ];
            "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
            "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
            "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

            "Mod+WheelScrollRight".action.focus-column-right = [ ];
            "Mod+WheelScrollLeft".action.focus-column-left = [ ];
            "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
            "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];

            "Mod+WheelScrollDown".action.focus-column-right = [ ];
            "Mod+WheelScrollUp".action.focus-column-left = [ ];
            "Mod+Ctrl+WheelScrollDown".action.move-column-right = [ ];
            "Mod+Ctrl+WheelScrollUp".action.move-column-left = [ ];

            "Mod+Shift+WheelScrollDown" = {
              action.focus-workspace-down = [ ];
              cooldown-ms = 150;
            };
            "Mod+Shift+WheelScrollUp" = {
              action.focus-workspace-up = [ ];
              cooldown-ms = 150;
            };
            "Mod+Shift+Ctrl+WheelScrollDown" = {
              action.move-column-to-workspace-down = [ ];
              cooldown-ms = 150;
            };
            "Mod+Shift+Ctrl+WheelScrollUp" = {
              action.move-column-to-workspace-up = [ ];
              cooldown-ms = 150;
            };

            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;
            "Mod+6".action.focus-workspace = 6;
            "Mod+7".action.focus-workspace = 7;
            "Mod+8".action.focus-workspace = 8;
            "Mod+9".action.focus-workspace = 9;
            "Mod+Ctrl+1".action.move-column-to-workspace = 1;
            "Mod+Ctrl+2".action.move-column-to-workspace = 2;
            "Mod+Ctrl+3".action.move-column-to-workspace = 3;
            "Mod+Ctrl+4".action.move-column-to-workspace = 4;
            "Mod+Ctrl+5".action.move-column-to-workspace = 5;
            "Mod+Ctrl+6".action.move-column-to-workspace = 6;
            "Mod+Ctrl+7".action.move-column-to-workspace = 7;
            "Mod+Ctrl+8".action.move-column-to-workspace = 8;
            "Mod+Ctrl+9".action.move-column-to-workspace = 9;

            "Mod+Alt+H".action.consume-or-expel-window-left = [ ];
            "Mod+Alt+L".action.center-column = [ ];

            "Mod+Comma".action.consume-window-into-column = [ ];
            "Mod+Period".action.expel-window-from-column = [ ];

            "Mod+R".action.switch-preset-column-width = [ ];
            "Mod+Shift+R".action.switch-preset-window-height = [ ];
            "Mod+Ctrl+R".action.reset-window-height = [ ];

            "Mod+F".action.maximize-column = [ ];
            "Mod+Shift+F".action.fullscreen-window = [ ];
            "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];

            "Mod+Minus".action.set-column-width = "-10%";
            "Mod+Plus".action.set-column-width = "+10%";

            "Mod+Shift+Minus".action.set-window-height = "-10%";
            "Mod+Shift+Plus".action.set-window-height = "+10%";

            "Mod+V".action.toggle-window-floating = [ ];
            "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

            "Mod+W".action.toggle-column-tabbed-display = [ ];

            "Mod+Space".action.switch-layout = "next";
            "Mod+Shift+Space".action.switch-layout = "prev";

            "Mod+S".action.screenshot = [ ];
            "Mod+Shift+S".action.screenshot-window = [ ];

            "Mod+Shift+M".action.power-off-monitors = [ ];

            "Mod+Escape" = {
              allow-inhibiting = false;
              action.toggle-keyboard-shortcuts-inhibit = [ ];
            };
          };
        };
      };
  };
}
