{
  den,
  eg,
  inputs,
  __findFile,
  ...
}: {
  den.aspects.nixLaptop = {
    # igloo host provides some home-manager defaults to its users.
    # homeManager.programs.direnv.enable = true;
    homeManager.home.stateVersion = "24.11";

    includes = [
      <eg/system/bluetooth>

      eg.bootloader
      eg.ly
      # eg.laptop
    ];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.hello
        pkgs.rpi-imager
        # pkgs.upower
      ];
      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;
      system.stateVersion = "24.11";

      time.timeZone = "Europe/Berlin";
    };

    # <host>.provides.<user>, via eg/routes.nix
    # provides.xelix = {user, ...}: {
    #   homeManager.programs.helix.enable = user.name == "xelix";
    # };
  };
}
