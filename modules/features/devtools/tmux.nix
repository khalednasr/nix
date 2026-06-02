{ self, inputs, ... }:
let
  name = "tmux";

  customPackage =
    pkgs:
    let
      killUnnamedSessions = pkgs.writeTextFile {
        name = "tmux_kill_unnamed_sessions";
        text = ''
          # !/bin/sh
          tmux ls -F '#{session_name}' -f '#{!:#{session_attached}}' \
          | grep "^[0-9]*$" \
          | xargs -r -I {} tmux kill-session -t {}
        '';
      };

      saveSession = pkgs.writeTextFile {
        name = "tmuxp_save_session";
        text = ''
          # !/bin/sh
          SESSION_NAME=$(tmux display-message -p '#S')

          if [[ -z $(echo $SESSION_NAME | grep "^[0-9]*$") ]]; then
            tmuxp freeze "$SESSION_NAME" --yes --force --quiet -o "$TMUXP_CONFIGDIR/$SESSION_NAME.yaml"
            tmux display-message "Session saved!"
          else
            tmux display-message "Session name connot be a number"
          fi
        '';
      };

      editSession = pkgs.writeTextFile {
        name = "tmuxp_edit_session";
        text = ''
          # !/bin/sh
          SESSION_NAME=$(tmux display-message -p '#S')
          SESSION_FILE="$TMUXP_CONFIGDIR/$SESSION_NAME.yaml"

          if test -f "$SESSION_FILE"; then
            tmux new-window "nvim '$SESSION_FILE'"
          else
            tmux display-message "Session must be saved before editing"
          fi
        '';
      };

      # fish = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
    in
    inputs.nix-wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;

      plugins = with pkgs.tmuxPlugins; [
        gruvbox
      ];

      sourceSensible = true;
      clock24 = true;
      mouse = true;
      baseIndex = 1;
      paneBaseIndex = 1;
      vimVisualKeys = true;
      modeKeys = "vi";
      prefix = "C-Space";
      # shell = "${fish}/bin/fish";

      configAfter = ''
        set-option -g renumber-windows on

        bind -n M-l select-pane -R
        bind -n M-h select-pane -L
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D

        bind -n M-p previous-window
        bind -n M-n next-window

        bind-key -n M-1 select-window -t 1
        bind-key -n M-2 select-window -t 2
        bind-key -n M-3 select-window -t 3
        bind-key -n M-4 select-window -t 4
        bind-key -n M-5 select-window -t 5
        bind-key -n M-6 select-window -t 6
        bind-key -n M-7 select-window -t 7
        bind-key -n M-8 select-window -t 8
        bind-key -n M-9 select-window -t 9

        bind -n M-t new-window -c "#{pane_current_path}"
        bind -n M-e split-window -h -c "#{pane_current_path}"
        bind -n M-w split-window -v -c "#{pane_current_path}" -l 20%
        bind -n M-q kill-pane

        bind -n M-Up resize-pane -U 5
        bind -n M-Down resize-pane -D 5
        bind -n M-Left resize-pane -L 5
        bind -n M-Right resize-pane -R 5

        bind -n M-s choose-tree -Zs

        bind -n M-v copy-mode

        bind s run-shell 'sh ${saveSession}'
        bind e run-shell 'sh ${editSession}'
        bind r command-prompt -I "#S" { rename-session "%%" }

        set-hook -g client-detached "run-shell 'sh ${killUnnamedSessions}'"
      '';
    };
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${name} = customPackage pkgs;
    };
}
