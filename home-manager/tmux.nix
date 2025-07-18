{
  # config,
  pkgs,
  # inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    extraConfig = ''            # used for less common options, intelligently combines if defined in multiple places.
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
      set -g detach-on-destroy off  # don't exit from tmux when closing a session
    '';

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode

      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };

  programs.sesh.enable = true;
  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
  };
}
