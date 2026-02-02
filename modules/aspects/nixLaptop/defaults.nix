{
  den.aspects.nixLaptop = {
    # igloo host provides some home-manager defaults to its users.
    homeManager.programs.direnv.enable = true;

    flake-file.inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos = {
      pkgs,
      inputs,
      eg,
      ...
    }: {
      includes = [
        eg.hw-detect
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      environment.systemPackages = [pkgs.hello];
    };

    # <host>.provides.<user>, via eg/routes.nix
    provides.xelix = {user, ...}: {
      homeManager.programs.helix.enable = user.name == "xelix";
    };
  };
}
