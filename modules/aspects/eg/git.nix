{
  eg.dev._.git = {user, ...}: {
    homeManager = {pkgs, ...}: {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        settings = {
          credential.helper = "libsecret";
        };
      };
      # programs.yubikey-agent.enable = true;
    };
    nixos = {pkgs, ...}: {
      services.pcscd.enable = true;
      services.udev.packages = [pkgs.yubikey-personalization];

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
