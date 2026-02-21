{
  eg.dev._.git = {user, ...}: {
    homeManager = {pkgs, ...}: {
      programs.git = {
        enable = true;
        packege = pkgs.gitFull;
        config = {
          credential.helper = "libsecret";
        };
      };
    };
  };
}
