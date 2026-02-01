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

  my.system-user =
    { pkgs, ... }:
    {
      users.users.xelix = {
        isNormalUser = true;
        description = "Felix Scherb";
        extraGroups = ["networkmanager" "wheel" "input" "dialout" "podman"];
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
    };

  my.user = <den.lib.parametric> {
    includes = [
      <den/primary-user>
      (<den/user-shell> "fish")
      <hm>
      <xelix/packages>
      <xelix/shell>
      <xelix/development>
      <xelix/terminal>
      <xelix/plasma>
      <xelix/file-chooser>
      <xelix/yazi>
      <xelix/niri>
      <xelix/zellij>
      <xelix/qutebrowser>
      <xelix/hyprland>
      <xelix/starship>
      <xelix/stylix>
    ];
  };
}