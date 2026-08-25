{ inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  aspects.noctalia = {

    nixos =
      { pkgs, ... }:
      {
        imports = [
          inputs.noctalia-greeter.nixosModules.default
        ];

        programs.noctalia-greeter = {
          enable = true;
          settings = {
            cursor = {
              theme = "Bibata-Modern-Ice";
              size = 24;
              path = "${pkgs.bibata-cursors}/share/icons";
            };
            keyboard = {
              layout = "de,us";
            };
          };
        };
      };

    homeManager =
      { pkgs, config, ... }:
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        home.packages = with pkgs; [ papirus-icon-theme ];

        programs.noctalia = {
          enable = true;

          settings = {
            control_center = {
              width = 900;
              shortcuts = [
                { type = "wifi"; }
                { type = "bluetooth"; }
                { type = "caffeine"; }
                { type = "power_profile"; }
              ];
            };

            bar.default = {
              end = [
                "tray"
                "clipboard"
                "network"
                "bluetooth"
                "volume"
                "brightness"
                "battery"
                "control-center"
                "session"
              ];

              start = [
                "launcher"
                "workspaces"
                "wallpaper"
                "wallhaven"
                "media"
              ];
            };

            plugins.enabled = [
              "noctalia/wallhaven"
            ];

            widget.wallhaven.type = "noctalia/wallhaven:wallhaven";

            idle = {
              behavior_order = [
                "lock"
                "screen-off"
                "lock-and-suspend"
              ];

              behavior.lock = {
                action = "lock";
                enabled = true;
                timeout = 600.0;
              };

              behavior.lock-and-suspend = {
                action = "lock_and_suspend";
                enabled = false;
                timeout = 900.0;
              };

              behavior.screen-off = {
                action = "screen_off";
                enabled = true;
                timeout = 660.0;
              };
            };

            location = {
              auto_locate = true;
            };

            shell = {
              polkit_agent = true;
              greeter_sync.auto_sync = false;

              panel = {
                launcher_placement = "attached";
                open_near_click_control_center = true;
                open_near_click_launcher = true;
                open_near_click_session = true;
              };
            };

            theme = {
              source = "community";
              community_palette = "Rose Pine Moon";
            };

            widget = {
              battery = {
                display_mode = "graphic";
                show_label = false;
              };

              brightness = {
                show_label = false;
              };

              media = {
                hide_when_no_media = true;
              };

              network = {
                show_label = false;
              };

              volume = {
                show_label = false;
              };
            };
          };
        };
      };

    provides.niri.homeManager = {
      programs.niri.settings = {
        spawn-at-startup = [ { sh = "QS_ICON_THEME=Papirus-Dark noctalia"; } ];

        layer-rules = [
          {
            matches = [ { namespace = "^noctalia-wallpaper*"; } ];
            place-within-backdrop = true;
          }
        ];

        binds = {
          "Mod+D".action.spawn-sh = "noctalia msg panel-toggle launcher";
          "Mod+P".action.spawn-sh = "noctalia msg panel-toggle session";
          "XF86MonBrightnessUp".action.spawn-sh = "noctalia msg brightness-up";
          "XF86MonBrightnessDown".action.spawn-sh = "noctalia msg brightness-down";

          "Mod+W".action.spawn-sh = ''
            TERMINAL="kitty"
            export TMUXP_CONFIGDIR="$HOME/.config/tmuxp"
            SESSION_NAME=$(ls $TMUXP_CONFIGDIR | sed -e 's/\.yaml$//' | noctalia dmenu);
            [ -n "$SESSION_NAME" ] && $TERMINAL tmuxp load --yes $SESSION_NAME
          '';
        };
      };

      xdg.configFile."niri/config.kdl".text = ''
        include optional=true "noctalia.kdl"
      '';

      programs.noctalia.settings.theme.templates.builtin_ids = [ "niri" ];
    };

    provides.kitty.homeManager = {
      programs.noctalia.settings.theme.templates.builtin_ids = [ "kitty" ];
      programs.kitty.extraConfig = "include themes/noctalia.conf";
    };
  };
}
