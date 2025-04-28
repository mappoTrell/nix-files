{
  description = "Home Manager configuration of xelix";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # url = "github:nix-community/nixvim/nixos-24.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    kickstart-nixvim ={
      url = "path:/home/xelix/programms/kickstart.nixvim";

      # url = "github:JMartJonesy/kickstart.nixvim";
      flake = false;
    };
    ard-port = {
      flake = false;
      url = "path:/home/xelix/.config/home-manager/arduino-port";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
#     editect = {
#       url = "path:/home/xelix/programms/editect";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
    bunny-yazi = {
      url = "github:stelcodes/bunny.yazi";
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."xelix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix

        ];

        # Optionally use extraSpecialArgs
        #extraSpecialArgs = { inherit Neve; };

        # to pass through arguments to home.nix
      };
    };
}
