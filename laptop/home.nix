
{
  config,
  pkgs,
  inputs,
  home-manager,
  ...
}: {
  imports = [
    ../home-manager/home.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      
      misc.vfr = true;
      
      decoration = {
        shadow.enabled = false;
        blur.enabled = false;
      };
    };

  };
}
