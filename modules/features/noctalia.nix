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

            brightness.enable_ddcutil = true;

            shell = {
              polkit_agent = true;
              greeter_sync.auto_sync = false;

              panel = {
                launcher_placement = "attached";
                open_near_click_control_center = true;
                open_near_click_launcher = true;
                open_near_click_session = true;
              };

              window_switcher = {
                current_workspace_only = true;
                mru = true;
                show_all_outputs = false;
                show_app_icon = false;
                show_caption = false;
                show_count = false;
                style = "compact";
              };
            };

            theme = {
              source = "builtin";
              builtin = "Rosé Pine";
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

    provides.umbriel.homeManager = { config, ... }: {
      programs.umbriel.settings = {
        general.autostart = [ "noctalia" ];

        keybinds = {
          "Mod+D" = "spawn noctalia msg panel-toggle launcher";
          "Mod+P" = "spawn noctalia msg panel-toggle session";

          "Alt+Tab" = "spawn noctalia msg window-switcher hold";
          "Alt+Shift+Tab" = "spawn noctalia msg window-switcher hold reverse";

          "Mod+Shift+S" = "spawn noctalia msg screenshot-annotate";

          "XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
          "XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";
          "XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
          "XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
          "XF86AudioMute" = "spawn noctalia msg volume-mute";

          "Mod+W" = ''
            spawn sh -c '
                        TERMINAL=${config.home.sessionVariables.TERMINAL}
                        export TMUXP_CONFIGDIR="$HOME/.config/tmuxp"
                        SESSION_NAME=$(ls $TMUXP_CONFIGDIR | sed -e 's/\.yaml$//' | noctalia dmenu);
                        [ -n "$SESSION_NAME" ] && $TERMINAL -e tmuxp load --yes $SESSION_NAME
                        '
          '';

          "Mod+S" = ''
            spawn sh -c '
                        TERMINAL=${config.home.sessionVariables.TERMINAL}
                        HOST=$(grep "^Host\s\+[^*]" $HOME/.ssh/config | cut -d " " -f 2- | noctalia dmenu)
                        [ -n "$HOST" ] && $TERMINAL -e fish -c "TERM=xterm-256color ssh $HOST; exec fish"
                        '
          '';
        };

        include.optional.files = [ "$HOME/.config/umbriel/noctalia.toml" ];
      };

      programs.noctalia.settings.theme.templates.builtin_ids = [ "umbriel" ];
    };

    provides.kitty.homeManager = {
      programs.noctalia.settings.theme.templates.builtin_ids = [ "kitty" ];
      programs.kitty.extraConfig = "include themes/noctalia.conf";
    };

    provides.ghostty.homeManager = {
      programs.noctalia.settings.theme.templates.builtin_ids = [ "ghostty" ];
      programs.ghostty.settings.theme = "noctalia";
    };
  };
}
