{
  config,
  pkgs,
  ...
}: {
  system.stateVersion = "24.05"; # Did you read the comment?
  networking.hostName = "nixos"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    pkgs.cudaPackages.cudatoolkit
    pkgs.cudaPackages.cuda_opencl
    pkgs.houdini
  ];
}
