{
  den,
  lib,
  ...
}: {
  eg.dev._.direnv = {
    user,
    home,
    ...
  }: {
    homeManager.programs = {
      direnv = {
        enable = true;
        enableFishIntegration = "fish" == user.shell;
        nix-direnv.enable = true;
      };
    };
  };
}
