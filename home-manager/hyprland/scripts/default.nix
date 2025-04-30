{
  pkgs,
  username,
  ...
}: {
  imports = [./night-shift.nix];
  home.packages = [
    (import ./keybinds.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
    (import ./filechooser.nix {inherit pkgs;})
  ];
}
