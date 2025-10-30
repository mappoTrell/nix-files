{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./scripts
    ./wofi.nix
    ./anyrun.nix
    ./animations.nix
    ./screenshootin.nix
    # ./walker.nix
  ];
}
