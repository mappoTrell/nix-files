{inputs, ...}: {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

  };
  
  eg.theming.provides.theme = theme : {
    nixos = {pkgs,config, ...}: {
      imports = [inputs.stylix.nixosModules.stylix];
      stylix = {
        enable = true;
        
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
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 18;
      };
    };

    polarity = "dark";
        base16Scheme =  "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
      };
    };
  };
}