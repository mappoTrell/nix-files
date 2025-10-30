{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./night-shift.nix
    ./system.nix
    ./screenshootin.nix
  ];
  home.packages = [
    (import ./keybinds.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
    # (import ./s.nix {inherit pkgs;})
  ];
}
