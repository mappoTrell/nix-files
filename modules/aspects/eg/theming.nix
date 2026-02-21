{inputs, ...}: {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.theming.provides.theme = {user, ...}: {
    homeManager = {
      stylix.targets.dank-material-shell.enable = false;
    };
    nixos = {
      pkgs,
      config,
      ...
    }: {
      imports = [inputs.stylix.nixosModules.stylix];
      config.stylix = {
        enable = true;

        cursor = {
          name = "rose-pine-cursor";
          package = with pkgs; rose-pine-hyprcursor;
          size = 20;
        };

        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrains Mono Nerd Font";
          };
          sansSerif = {
            package = pkgs.source-sans-pro;
            name = "Source Sans Pro";
          };
          # serif = config.stylix.fonts.sansSerif;
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
          sizes = {
            applications = 18;
            desktop = 18;
            popups = 18;
            terminal = 18;
          };
        };

        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${user.conf.theme}.yaml";

        image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/anime-skyline_purple.png";
          sha256 = "sha256-ywhiNf1zANksKkk066aJirOqa0d1rPuijKUFAljDp/M=";
        };
      };
    };
  };
}
