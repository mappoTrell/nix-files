{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = "24.05"; # Did you read the comment?
  networking.hostName = "nixos"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    pkgs.cudaPackages.cudatoolkit
    pkgs.cudaPackages.cuda_opencl
    pkgs.houdini
  ];

             home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xelix = ./desktop/home.nix;
            

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix

}
