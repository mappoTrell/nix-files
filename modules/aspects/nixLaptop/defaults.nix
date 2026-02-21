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
      eg.system
      # eg.laptop
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.hello];
    };

    # <host>.provides.<user>, via eg/routes.nix
    provides.xelix = {user, ...}: {
      homeManager.programs.helix.enable = user.name == "xelix";
    };
  };
}
