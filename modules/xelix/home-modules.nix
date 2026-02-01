{
  xelix.yazi = { pkgs, ... }: { imports = [ ../../home-manager/yazi.nix ]; };
  xelix.niri = { pkgs, ... }: { imports = [ ../../home-manager/niri ]; };
  xelix.zellij = { pkgs, ... }: { imports = [ ../../home-manager/zellij.nix ]; };
  xelix.qutebrowser = { pkgs, ... }: { imports = [ ../../home-manager/qutebrowser.nix ]; };
  xelix.hyprland = { pkgs, ... }: { imports = [ ../../home-manager/hyprland ]; };
  xelix.starship = { pkgs, ... }: { imports = [ ../../home-manager/starship.nix ]; };
  xelix.stylix = { pkgs, ... }: { imports = [ ../../shared/stylix ]; };
}