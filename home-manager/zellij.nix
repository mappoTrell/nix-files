{pkgs}: {
  programms.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      post_command_discovery_hook = "echo \"$RESURRECT_COMMAND\" | sed 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g'";
      # default_layout = "compact";
    };
  };
}
