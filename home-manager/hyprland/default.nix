{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./scripts
    ./anyrun.nix
    ./animations.nix
  ];
}
