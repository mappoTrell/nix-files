{
  config,
  # deadnix: skip # enable <den/brackets> syntax for demo.
  __findFile ? __findFile,
  den,
  pkgs,
  lib,
  ...
}: {
  # Lets also configure some defaults using aspects.
  # These are global static settings.
  den.schema.host.homeManager.enable = true;
  den.default = {
    darwin.system.stateVersion = 6;
    nixos.system.stateVersion = lib.mkDefault "25.05";
    homeManager.home.stateVersion = lib.mkDefault "25.05";
    nixos.networking.networkmanager.enable = true;
    nixos.nix.settings.experimental-features = ["nix-command" "flakes"];
  };

  # These are functions that produce configs
  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    <eg/routes>
    # <eg/niri>

    # Enable home-manager on all hosts.
    # <den/home-manager>

    # Automatically create the user on host.
    # <den/define-user>
    den.provides.define-user
    # den.provides.self'
    den.provides.inputs'
    # Disable booting when running on CI on all NixOS hosts.
    (
      if config ? _module.args.CI
      then <eg/ci-no-boot>
      else {}
    )

    # den.provides.hostname

    # NOTE: be cautious when adding fully parametric functions to defaults.
    # defaults are included on EVERY host/user/home, and IF you are not careful
    # you could be duplicating config values. For example:
    #
    #  # This will append 42 into foo option for the {host} and for EVERY {host,user}
    #  ({ host, ... }: { nixos.foo = [ 42 ]; }) # DO-NOT-DO-THIS.
    #
    #  # Instead try to be explicit if a function is intended for ONLY { host }.
    # (den.lib.take.exactly (
    #   {
    #     OS,
    #     host,
    #   }:
    #     den.lib.take.unused OS {
    #       nixos.networking.hostName = host.hostName;
    #     }
    # ))
  ];
}
