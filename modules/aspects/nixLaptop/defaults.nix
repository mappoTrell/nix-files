{
  den,
  eg,
  inputs,
  __findFile,
  ...
}: {
  den.aspects.nixLaptop = {aspects, ...}: {
    # igloo host provides some home-manager defaults to its users.
    homeManager.programs.direnv.enable = true;

    includes = [
      <eg/bluetooth>

      eg.bootloader
      eg.ly
      # eg.laptop
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.hello];

      time.timeZone = "Europe/Berlin";
    };

    # <host>.provides.<user>, via eg/routes.nix
    provides.xelix = {user, ...}: {
      homeManager.programs.helix.enable = user.name == "xelix";
    };
  };
}
