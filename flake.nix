{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
      url = "/home/xelix/programms/kickstart.nixvim";

      # url = "github:JMartJonesy/kickstart.nixvim";
      flake = false;
    };
    ard-port = {
      flake = false;
      url = "path:/home/xelix/nixos/home-manager/arduino-port/portable";
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

    # use the following for unstable:
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    # or any branch you want:
    # nixpkgs.url = "nixpkgs/{BRANCH-NAME}";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager,... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
             ./shared/configuration.nix 
              ./desktop/nvidia.nix
              ./desktop/hardware-configuration.nix
              ./desktop/conf.nix
               
          ];

      };
        nixLaptop = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
             ./shared/configuration.nix 
              nixos-hardware.nixosModules.framework-13-7040-amd
              ./laptop/hardware-configuration.nix

              ./laptop/conf.nix
               
          ];

      };
    };
      homeConfigurations."xelix@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-manager/home.nix

        ];

        # Optionally use extraSpecialArgs
        #extraSpecialArgs = { inherit Neve; };

        # to pass through arguments to home.nix
      };
      homeConfigurations."xelix@nixLaptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-manager/home.nix

        ];

        # Optionally use extraSpecialArgs
        #extraSpecialArgs = { inherit Neve; };

        # to pass through arguments to home.nix
      };
  };
}
