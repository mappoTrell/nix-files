{
  pkgs,
  username,
  ...
}: {
  imports = [./night-shift.nix
    ./system.nix
  ];
  home.packages = [
    (import ./keybinds.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
  ];
}
