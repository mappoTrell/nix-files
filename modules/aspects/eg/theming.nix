{inputs, ...}: {
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

  };
  
  eg.theming.provides.theme = {theme, ...} : {
    nixos = {
      imports = [inputs.stylix.nixosModules.stylix];
      stylix = {
        enable = true;
        base16 = theme;
      };
    };
  };
}