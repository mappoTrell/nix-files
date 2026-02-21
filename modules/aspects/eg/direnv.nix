{
  den,
  lib,
  ...
}: {
  eg.dev._.direnv = {user, ...}: {
    homeManager.programs = {
      direnv = {
        enable = true;
        enableFishIntegration = user.conf.shell == "fish";
        enableBashIntegration = user.conf.shell == "bash";
        enableZshIntegration = user.conf.shell == "zsh";
        nix-direnv.enable = true;
      };
    };
  };
}
