{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    superfile = {
      url = "github:yorukot/superfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.dev._.superfile = {
    homeManager = {
      pkgs,
      stdenv,
      ...
    }: {
      xdg.desktopEntries = {
        my-custom-app = {
          name = "superfile";
          comment = "superfile";
          exec = "${pkgs.lib.getExe pkgs.ghostty} -e superfile";
          # icon = "${pkgs.my-custom-app}/share/icons/hicolor/256x256/apps/my-custom-app.png";
          terminal = false;
          categories = ["Utility"];
        };
      };
      programs.superfile = {
        enable = true;
        package = inputs.superfile.packages.${stdenv.hostPlatform.system}.default;
      };
    };
  };
}
