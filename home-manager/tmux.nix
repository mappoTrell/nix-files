# {
#   # config,
#   pkgs,
#   # inputs,
#   ...
# }: {
#   programs.tmux = {
#     enable = true;
#     clock24 = true;
#     escapeTime = 0;
#     keyMode = "vi";
#     shortcut = "a";
#     extraConfig = ''            # used for less common options, intelligently combines if defined in multiple places.
#       bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
#       set -g detach-on-destroy off  # don't exit from tmux when closing a session
#     '';
#
#     plugins = with pkgs; [
#       tmuxPlugins.better-mouse-mode
#
#       {
#         plugin = tmuxPlugins.resurrect;
#         extraConfig = ''
#           set -g @resurrect-strategy-vim 'session'
#           set -g @resurrect-strategy-nvim 'session'
#           set -g @resurrect-capture-pane-contents 'on'
#           resurrect_dir=~/.tmux/resurrect/
#           set -g @resurrect-dir $resurrect_dir
#           set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f $resurrect_dir/last)"
#         '';
#       }
#       {
#         plugin = tmuxPlugins.continuum;
#         extraConfig = ''
#           set -g @continuum-restore 'on'
#           set -g @continuum-boot 'on'
#           set -g @continuum-save-interval '10'
#         '';
#       }
#     ];
#   };
#
#   programs.sesh.enable = true;
#   programs.fzf = {
#     enable = true;
#     tmux.enableShellIntegration = true;
#   };
# }
# tmux.nix
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  continuum = pkgs.tmuxPlugins.continuum.overrideAttrs (oldAttrs: {
    version = "unstable-2024-01-20";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-continuum";
      rev = "0698e8f4b17d6454c71bf5212895ec055c578da0";
      sha256 = "sha256-W71QyLwC/MXz3bcLR2aJeWcoXFI/A3itjpcWKAdVFJY=";
    };
  });
  resurrect = pkgs.tmuxPlugins.resurrect;
  resurrect-tmux-sessions = pkgs.writeShellApplication {
    name = "resurrect-tmux-sessions";
    text = ''
      # Assumes `tmux` in PATH.
      # Note: Do *not* run `..../restore.sh` directly (i.e. without `tmux
      # run-shell`) because it would screw up window layouts (maybe due to
      # catppuccin?). `tmux run-shell` only works when tmux is running (i.e. an
      # initial session needs to be started).
      tmux run-shell ${resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    resurrect-tmux-sessions
  ];

  programs.fish.shellInit = ''
    function restore-tmux-sessions
      if tmux info &> /dev/null
        set --local sessions (tmux list-sessions | cut -d: -f 1 | paste -s)
        set --local session (tmux display-message -p "#S")
        if string match --quiet "0" $session; and string match "0" $sessions
          echo "Ctrl+C or restoring Tmux..." && sleep 5 && ${resurrect-tmux-sessions}/bin/resurrect-tmux-sessions
        else
          echo "Too many sessions." >&2
        end
      else
        echo "Tmux not running." >&2
      end
    end

    restore-tmux-sessions 2>/dev/null
  '';

  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.catppuccin
      resurrect
      continuum
    ];
    extraConfigBeforePlugins = ''
      set -g @continuum-save-interval '5'
      set -g status-right 'Continuum: #{continuum_status}'

      set -g @catppuccin_flavor 'frappe'
      set -g @catppuccin_window_current_text " #{window_name}"
      set -g @catppuccin_window_text " #{window_name}"
    '';
    extraConfig = ''
      set -g status-left-length 100 # otherwise, the session name gets abbreviated
      set -g status-left "#{E:@catppuccin_status_session}"
    '';
  };
}
