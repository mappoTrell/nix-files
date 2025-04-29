
{
  pkgs,
  username,
  ...
}: {
  home.packages = [
    (import ./keybinds.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
  ];
}
