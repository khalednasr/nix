{
  aspects.vivaldi.homeManager =
    { pkgs, lib, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.vivaldi;
      };

      home.activation =
        let
          patchJson =
            path: options:
            lib.hm.dag.entryAfter [ "linkGeneration" ] ''
              ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$HOME/${path}")"
              temp="$(${pkgs.coreutils}/bin/mktemp)"
              (${pkgs.coreutils}/bin/cat "$HOME/${path}" 2>/dev/null || printf '%s' '{}') \
                | ${pkgs.jq}/bin/jq --argjson patch ${lib.escapeShellArg (builtins.toJSON options)} '. * $patch' > "$temp"
              ${pkgs.coreutils}/bin/mv "$temp" "$HOME/${path}"
            '';
        in
        {
          vivaldiPrefs = patchJson ".config/vivaldi/Default/Preferences" {
            vivaldi.startup.has_seen_feature = 1;
            vivaldi.startup.has_seen_welcome_page = true;
            vivaldi.system.show_exit_confirmation_dialog = false;
            vivaldi.theme.schedule.o_s = {
              dark = "Vivaldi2";
              light = "Vivaldi2";
            };
            vivaldi.actions = [
              {
                COMMAND_ADD_BOOKMARK.shortcuts = [ "ctrl+b" ];

                COMMAND_CLIPBOARD_COPY.shortcuts = [ "ctrl+c" ];
                COMMAND_CLIPBOARD_CUT.shortcuts = [ "ctrl+x" ];
                COMMAND_CLIPBOARD_PASTE.shortcuts = [ "ctrl+v" ];
                COMMAND_CLIPBOARD_PASTE_AS_PLAIN_TEXT_OR_PASTE_AND_GO.shortcuts = [ "ctrl+shift+v" ];
                COMMAND_CLIPBOARD_REDO.shortcuts = [ "ctrl+y" ];
                COMMAND_CLIPBOARD_SELECT_ALL.shortcuts = [ "ctrl+a" ];
                COMMAND_CLIPBOARD_UNDO.shortcuts = [ "ctrl+z" ];

                COMMAND_NEW_TAB.shortcuts = [ "ctrl+t" ];
                COMMAND_TAB_REOPEN_RECENTLY_CLOSED.shortcuts = [ "ctrl+shift+t" ];
                COMMAND_CLOSE_ALL_BUT_ACTIVE_TAB.shortcuts = [ "ctrl+shift+w" ];
                COMMAND_CLOSE_TAB_TO_LEFT.shortcuts = [ "ctrl+shift+q" ];
                COMMAND_CLOSE_TAB_TO_RIGHT.shortcuts = [ "ctrl+shift+e" ];
                COMMAND_CLOSE_TAB.shortcuts = [ "ctrl+w" ];
                COMMAND_TAB_SWITCH_FORWARD_ORDER.shortcuts = [ "ctrl+l" ];
                COMMAND_TAB_SWITCH_BACK_ORDER.shortcuts = [ "ctrl+h" ];
                COMMAND_TAB_MOVE_BACKWARD.shortcuts = [ "ctrl+shift+h" ];
                COMMAND_TAB_MOVE_FORWARD.shortcuts = [ "ctrl+shift+l" ];

                COMMAND_FIND_IN_PAGE.shortcuts = [ "ctrl+f" ];
                COMMAND_FIND_NEXT_IN_PAGE.shortcuts = [ "ctrl+n" ];
                COMMAND_FIND_PREVIOUS_IN_PAGE.shortcuts = [ "ctrl+p" ];

                COMMAND_FOCUS_ADDRESSFIELD.shortcuts = [ "ctrl+i" ];

                COMMAND_MAIN_ZOOM_IN.shortcuts = [ "ctrl++" ];
                COMMAND_MAIN_ZOOM_OUT.shortcuts = [ "ctrl+-" ];
                COMMAND_MAIN_ZOOM_RESET.shortcuts = [ "ctrl+shift++" ];

                COMMAND_NEW_PRIVATE_WINDOW.shortcuts = [ "ctrl+shift+n" ];

                COMMAND_PAGE_BACK.shortcuts = [ "ctrl+j" ];
                COMMAND_PAGE_FORWARD.shortcuts = [ "ctrl+k" ];
                COMMAND_PAGE_REFRESH.shortcuts = [ "ctrl+r" ];
                COMMAND_PAGE_RELOAD_NOCACHE.shortcuts = [ "ctrl+shift+r" ];

                COMMAND_PRINT_PAGE.shortcuts = [ "ctrl+shift+p" ];

                COMMAND_SHOW_QUICK_COMMANDS.shortcuts = [ "ctrl+e" ];
                COMMAND_SHOW_BOOKMARK_PANEL.shortcuts = [ "alt+b" ];
                COMMAND_SHOW_DOWNLOADS_PANEL.shortcuts = [ "alt+j" ];
                COMMAND_SHOW_HISTORY_PANEL.shortcuts = [ "alt+h" ];
                COMMAND_SHOW_MAIL_PANEL.shortcuts = [ "alt+m" ];
                COMMAND_SHOW_NOTES_PANEL.shortcuts = [ "alt+n" ];
                COMMAND_SHOW_TRANSLATE_PANEL.shortcuts = [ "alt+t" ];

                COMMAND_TAB_SWITCH_1.shortcuts = [ "alt+1" ];
                COMMAND_TAB_SWITCH_2.shortcuts = [ "alt+2" ];
                COMMAND_TAB_SWITCH_3.shortcuts = [ "alt+3" ];
                COMMAND_TAB_SWITCH_4.shortcuts = [ "alt+4" ];
                COMMAND_TAB_SWITCH_5.shortcuts = [ "alt+5" ];
                COMMAND_TAB_SWITCH_6.shortcuts = [ "alt+6" ];
                COMMAND_TAB_SWITCH_7.shortcuts = [ "alt+7" ];
                COMMAND_TAB_SWITCH_8.shortcuts = [ "alt+8" ];
                COMMAND_TAB_SWITCH_9.shortcuts = [ "alt+9" ];
              }
            ];
          };
        };
    };

  aspects.vivaldi.provides.niri.homeManager = {
    programs.niri.settings.binds = {
      "Mod+B".action.spawn = "vivaldi";
    };
  };
}
