{
  eg.dev._.zoxide = {user, ...}: {
    homeManager = {pkgs, ...}: {
      programs.zoxide = {
        enable = true;

        enableFishIntegration = user.conf.shell == "fish";
        enableBashIntegration = user.conf.shell == "bash";
        enableZshIntegration = user.conf.shell == "zsh";
      };
    };
  };
}
