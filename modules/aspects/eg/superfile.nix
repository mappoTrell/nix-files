{
  den,
  inputs,
  lib,
  config,
  # stdenv,
  ...
}: {
  flake-file.inputs = {
    superfile = {
      url = "github:yorukot/superfile";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.dev._.superfile = {
    options.myOption = lib.mkOption {
      default = false;
      description = "This is my custom option.";
      type = lib.types.bool; # Specifies that the option should be a string
    };

    homeManager = {
      pkgs,
      # config,
      # stdenv,
      ...
    }: {
      xdg.desktopEntries = {
        superfile = {
          name = "superfile";
          comment = "superfile";
          exec = "${pkgs.lib.getExe pkgs.ghostty} -e superfile";
          # icon = "${pkgs.my-custom-app}/share/icons/hicolor/256x256/apps/my-custom-app.png";
          terminal = false;
          categories = ["Utility"];
        };
      };
      home.packages = [
        pkgs.wl-clipboard
      ];
      programs.superfile = {
        enable = true;
        # package = inputs.superfile.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
