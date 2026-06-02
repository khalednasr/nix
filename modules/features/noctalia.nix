{ lib, inputs, ... }:
{
  flake-file.inputs = {
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  aspects.noctalia = {
    nixos.programs.dconf.enable = true;

    homeManager =
      { pkgs, config, ... }:
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        fonts.fontconfig.enable = true;
        home.packages = with pkgs; [
          ubuntu-sans
          ubuntu-sans-mono
          ubuntu-classic
          papirus-icon-theme
        ];

        programs.noctalia-shell = {
          enable = true;

          plugins = {
            sources = [
              {
                enabled = true;
                name = "Official Noctalia Plugins";
                url = "https://github.com/noctalia-dev/noctalia-plugins";
              }
            ];

            version = 2;
          };

          settings = {
            settingsVersion = 59;
            general.enableBlurBehind = false;

            colorSchemes = {
              useWallpaperColors = true;
              generationMethod = "tonal-spot";
            };

            ui = {
              fontDefault = "Ubuntu";
              fontFixed = "Ubuntu Sans Mono";
              panelsAttachedToBar = false;
              settingsPanelMode = "centered";
            };

            brightness = {
              brightnessStep = 5;
              enforceMinimum = true;
              enableDdcSupport = true;
            };

            location = {
              autoLocate = true;
            };

            bar = {
              useSeparateOpacity = true;
              backgroundOpacity = 0;
              density = "comfortable";
              widgets = {
                left = [
                  { id = "Launcher"; }
                  {
                    id = "Workspace";
                    hideUnoccupied = true;
                    showApplications = true;
                    labelMode = "none";
                  }
                  {
                    id = "Spacer";
                    width = 40;
                  }
                  {
                    id = "MediaMini";
                    hideMode = "hidden";
                    showVisualizer = true;
                  }
                ];
                center = [
                  { id = "WallpaperSelector"; }
                  { id = "Clock"; }
                  { id = "Settings"; }
                ];
                right = [
                  { id = "Tray"; }
                  { id = "Volume"; }
                  { id = "Brightness"; }
                  { id = "Bluetooth"; }
                  { id = "Network"; }
                  { id = "Battery"; }
                  { id = "ControlCenter"; }
                ];
              };
            };
          };
        };
      };

    provides.niri.homeManager = {
      programs.niri.settings = {
        spawn-at-startup = [ { sh = "QS_ICON_THEME=Papirus-Dark noctalia-shell"; } ];

        layer-rules = [
          {
            matches = [ { namespace = "^noctalia-wallpaper*"; } ];
            place-within-backdrop = true;
          }
        ];

        binds = {
          "Mod+D".action.spawn-sh = "noctalia-shell ipc call launcher toggle";
          "Mod+Shift+P".action.spawn-sh = "noctalia-shell ipc call sessionMenu toggle";
          "XF86MonBrightnessUp".action.spawn-sh = "noctalia-shell ipc call brightness increase";
          "XF86MonBrightnessDown".action.spawn-sh = "noctalia-shell ipc call brightness decrease";
        };
      };

      xdg.configFile."niri/config.kdl".text = ''
        include optional=true "noctalia.kdl"
      '';

      programs.noctalia-shell.settings.templates.activeTemplates = [
        {
          id = "niri";
          enabled = true;
        }
      ];
    };

    provides.kitty.homeManager = {
      programs.kitty.extraConfig = "include themes/noctalia.conf";

      programs.noctalia-shell.settings = {
        appLauncher = {
          terminalCommand = "kitty -e";
        };

        templates.activeTemplates = [
          {
            id = "kitty";
            enabled = true;
          }
        ];
      };
    };

    provides.fuzzel.homeManager =
      { config, ... }:
      {
        programs.noctalia-shell.settings = {
          templates.activeTemplates = [
            {
              id = "fuzzel";
              enabled = true;
            }
          ];
        };

        programs.fuzzel.settings = {
          main = {
            include = "~/.config/fuzzel/themes/noctalia";
            font = config.programs.noctalia-shell.settings.ui.fontDefault;
          };
        };
      };
  };

}
