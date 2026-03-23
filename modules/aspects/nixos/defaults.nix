{
  den,
  eg,
  inputs,
  __findFile,
  ...
}: {
  den.aspects.nixos = {aspects, ...}: {
    shell = "fish";
    # igloo host provides some home-manager defaults to its users.
    # homeManager.programs.direnv.enable = true;

    homeManager.home.stateVersion = "24.11"; # Please read the comment before changing.

    includes = [
      eg.nvidia
      eg.bootloader
      eg.ly
      # eg.system.bluetooth
      <eg/system/bluetooth>
      # eg.laptop
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.hello];
      system.stateVersion = "24.05"; # Did you read the comment?

      time.timeZone = "Europe/Berlin";
    };

    # <host>.provides.<user>, via eg/routes.nix
    # provides.xelix = {user, ...}: {
    #   homeManager.programs.helix.enable = user.name == "xelix";
    # };
  };
}
