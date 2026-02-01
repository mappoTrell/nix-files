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

  my.user =
    { pkgs, ... }:
    {
      users.users.xelix = {
        isNormalUser = true;
        description = "Felix Scherb";
        extraGroups = ["networkmanager" "wheel" "input" "dialout" "podman"];
        shell = pkgs.fish;
      };

      programs.fish.enable = true;

      home.username = "xelix";
      home.homeDirectory = "/home/xelix";
      home.stateVersion = "24.11";

      programs.home-manager.enable = true;
      services.ssh-agent.enable = true;

      home.sessionVariables = {
        SSH_AUTH_SOCK = /run/user/1000/ssh-agent;
        EDITOR = "nvim";
      };
    };
}