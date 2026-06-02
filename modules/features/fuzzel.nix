{ den, lib, ... }:
{
  aspects.fuzzel = {
    homeManager = {
      programs.fuzzel.enable = true;
    };

    provides.niri.homeManager =
      { config, ... }:
      {
        programs.niri.settings = {
          binds = {
            "Mod+W" = {
              action.spawn-sh = ''
                TERMINAL="${config.programs.fuzzel.settings.main.terminal}"
                export TMUXP_CONFIGDIR="$HOME/.config/tmuxp"
                SESSION_NAME=$(ls $TMUXP_CONFIGDIR | sed -e 's/\.yaml$//' | fuzzel --dmenu);
                [ -n "$SESSION_NAME" ] && $TERMINAL tmuxp load --yes $SESSION_NAME
              '';
            };

            "Mod+Shift+W" = {
              action.spawn-sh = ''
                TERMINAL="${config.programs.fuzzel.settings.main.terminal}"

                HOST=$(grep "^Host\s\+[^*]" $HOME/.ssh/config | cut -d " " -f 2- | fuzzel --dmenu)

                if [[ -n "$HOST" ]]; then
                  if ssh-keyscan $HOST >/dev/null 2>&1; then
                    TMUXP_CONFIGDIR_REMOTE=$(ssh $HOST "echo \$TMUXP_CONFIGDIR")

                    if [[ -n "$TMUXP_CONFIGDIR_REMOTE" ]]; then
                      SESSIONS="$(ssh $HOST "ls $TMUXP_CONFIGDIR_REMOTE | sed -e 's/\.yaml$//'")"$'\nnew session'

                      SESSION=$(echo "$SESSIONS" | fuzzel --dmenu)

                      if [[ -n "$SESSION" ]]; then
                        if [ "$SESSION" = "new session" ]; then
                          $TERMINAL ssh $HOST -t tmux
                        else
                          $TERMINAL ssh $HOST -t "tmuxp load $SESSION --yes"
                        fi
                      fi
                    fi
                  else
                    fuzzel --dmenu --prompt-only="Failed to connect to host"
                  fi
                fi
              '';
            };
          };
        };
      };
  };
}
