{
  den,
  eg,
  inputs,
  ...
}: {
  den.aspects.nixLaptop = {
    # igloo host provides some home-manager defaults to its users.
    homeManager.programs.direnv.enable = true;

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.hello];
    };

    # <host>.provides.<user>, via eg/routes.nix
    provides.xelix = {user, ...}: {
      homeManager.programs.helix.enable = user.name == "xelix";
    };
  };
}
