# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    anyrun = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:anyrun-org/anyrun";
    };
    ard-port = {
      flake = false;
      url = "path:/home/xelix/nix-files/home-manager/arduino-port/portable";
    };
    bunny-yazi = {
      flake = false;
      url = "github:stelcodes/bunny.yazi";
    };
    dankMaterialShell = {
      inputs.dgop.follows = "dgop";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AvengeMedia/DankMaterialShell";
    };
    den.url = "github:vic/den";
    dgop = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AvengeMedia/dgop";
    };
    elephant = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:abenz1267/elephant";
    };
    flake-aspects.url = "github:vic/flake-aspects";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprland-plugins = {
      inputs.hyprland.follows = "hyprland";
      url = "github:hyprwm/hyprland-plugins";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    import-tree.url = "github:vic/import-tree";
    niri = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sodiboo/niri-flake";
    };
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-lib.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    plasma-manager = {
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/plasma-manager";
    };
    stylix.url = "github:nix-community/stylix";
    walker = {
      inputs.elephant.follows = "elephant";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:abenz1267/walker";
    };
  };
}