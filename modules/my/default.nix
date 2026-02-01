{
  my.nvidia-desktop =
    { pkgs, ... }:
    {
      system.stateVersion = "24.05";
      networking.hostName = "nixos";

      environment.systemPackages = with pkgs; [
        pkgs.cudaPackages.cudatoolkit
        pkgs.cudaPackages.cuda_opencl
        pkgs.houdini
      ];
    };

  my.desktop-hardware =
    { pkgs, ... }:
    {
      # Import hardware-specific configurations
      imports = [
        ../../desktop/hardware-configuration.nix
        ../../desktop/nvidia.nix
      ];
    };

  my.laptop-hardware =
    { pkgs, ... }:
    {
      system.stateVersion = "24.11";
      networking.hostName = "nixLaptop";

      imports = [
        ../../laptop/hardware-configuration.nix
      ];
    };

  my.user-config =
    { pkgs, lib, ... }:
    {
      users.users.xelix = {
        isNormalUser = true;
        description = "Felix Scherb";
        extraGroups = ["networkmanager" "wheel" "input" "dialout" "podman"];
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
    };
}