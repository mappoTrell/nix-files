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
      <my/system-user>
      <my/user>
    ];

    xelix-laptop.includes = [
      <my/system-user>
      <my/user>
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