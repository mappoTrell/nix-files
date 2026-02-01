{ __findFile, inputs, ... }:
{
  den.hosts.x86_64-linux.nixos.users.xelix.aspect = "xelix-desktop";
  den.hosts.x86_64-linux.nixLaptop.users.xelix.aspect = "xelix-laptop";

  den.homes.x86_64-linux.xelix = {
    aspect = "xelix-desktop";
    instantiate = { pkgs, modules }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs modules;
        extraSpecialArgs.osConfig = inputs.self.nixosConfiguration.nixos.config;
      };
  };

  den.homes.x86_64-linux.xelix-laptop = {
    aspect = "xelix-laptop";
    instantiate = { pkgs, modules }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs modules;
        extraSpecialArgs.osConfig = inputs.self.nixosConfiguration.nixLaptop.config;
      };
  };

  den.aspects = {
    xelix-desktop.includes = [
      <my/user>
      <xelix/packages>
      <xelix/shell>
      <xelix/development>
      <xelix/terminal>
      <xelix/plasma>
      <xelix/nvidia-env>
      <xelix/file-chooser>
      <xelix/yazi>
      <xelix/niri>
      <xelix/zellij>
      <xelix/qutebrowser>
      <xelix/hyprland>
      <xelix/starship>
      <xelix/stylix>
      <hm>
    ];

    xelix-laptop.includes = [
      <my/user>
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
      <hm>
    ];

    nixos.includes = [
      <xelix/nvidia-desktop>
      <my/desktop-hardware>
    ];

    nixLaptop.includes = [
      <my/laptop-hardware>
    ];
  };
}