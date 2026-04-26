{
  den,
  inputs,
  lib,
  config,
  # stdenv,
  ...
}: {
  flake-file.inputs = {
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins?ref=yazi-v0.2.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.dev._.yazi = {
    homeManager = {pkgs, ...}: {
      imports = [
        (inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default)
      ];

      programs.yazi = {
        enable = true;
      };

      programs.yazi.yaziPlugins = {
        enable = true;
        plugins = {
          starship.enable = true;
          ouch.enable = true;
          hide-preview.enable = true;
          rich-preview.enable = true;
          system-clipboard.enable = true;
          bypass.enable = true;
          recycle-bin.enable = true;
          glow.enable = true;
          jump-to-char = {
            enable = true;
            keys.toggle.on = ["F"];
          };
          relative-motions = {
            enable = true;
            show_numbers = "relative_absolute";
            show_motion = true;
          };
        };
      };
    };
  };
}
