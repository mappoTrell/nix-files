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
    shortcut = "a";
    # extraConfig = ''      # used for less common options, intelligently combines if defined in multiple places.
    # '';

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
}
