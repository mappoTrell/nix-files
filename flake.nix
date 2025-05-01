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
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    stylix.url = "github:danth/stylix";

    kickstart-nixvim = {
      url = "/home/xelix/programms/kickstart.nixvim";

      # url = "github:JMartJonesy/kickstart.nixvim";
      flake = false;
    };
    ard-port = {
      flake = false;
      url = "path:/home/xelix/nix-files/home-manager/arduino-port/portable";
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

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};
        modules = [
          ./shared/configuration.nix
          ./desktop/nvidia.nix
          ./desktop/hardware-configuration.nix
          ./desktop/conf.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./shared/stylix
        ];
      };

      nixLaptop = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./shared/configuration.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
          ./laptop/hardware-configuration.nix

          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./laptop/conf.nix
        ];
      };
    };
    homeConfigurations."xelix@nixos" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home-manager/home.nix

        {
          wayland.windowManager.hyprland = {
            settings.env = [
              "LIBVA_DRIVER_NAME , nvidia" # Hardware video acceleration
              "XDG_SESSION_TYPE , wayland" # Force ayland
              "M_BACKEND , nvidia-drm" # Graphics backend for Wayland
              "__GLX_VENDOR_LIBRARY_NAME , nvidia" # Use Nvidia driver for GLX
              "WLR_NO_HARDWARE_CURSORS , 1" # Fix for cursors on Wayland
              "NIXOS_OZONE_WL , 1" # Wayland support for Electron apps
              "__GL_GSYNC_ALLOWED , 1" # Enable G-Sync if available
              "__GL_VRR_ALLOWED , 1" # Enable VRR (Variable Refresh Rate)
              "WLR_DRM_NO_ATOMIC , 1" # Fix for some issues with Hyprland
              "NVD_BACKEND , direct" # Configuration for new driver
              "MOZ_ENABLE_WAYLAND , 1" # Wayland support for Firefox
            ];
          };
        }
      ];

      # Optionally use extraSpecialArgs
      #extraSpecialArgs = { inherit Neve; };

      # to pass through arguments to home.nix
    };
    homeConfigurations."xelix@nixLaptop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home-manager/home.nix
      ];

      # Optionally use extraSpecialArgs
      #extraSpecialArgs = { inherit Neve; };

      # to pass through arguments to home.nix
    }; # flake.nix
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
