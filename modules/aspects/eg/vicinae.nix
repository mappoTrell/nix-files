{inputs, ...}: {
  flake-file.inputs = {
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.vicinae.homeManager = {pkgs, ...}: {
    programs.vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true; # default: false
        # environment = {
        #   USE_LAYER_SHELL = 1;
        # };
      };
      settings = pkgs.lib.mkForce {
        close_on_focus_loss = true;
        consider_preedit = true;
        pop_to_root_on_close = true;
        favicon_service = "twenty";
        search_files_in_root = true;
        font = {
          normal = {
            size = 12;
            family = "Maple Nerd Font";
          };
        };
        theme = {
          light = {
            name = "vicinae-light";
            icon_theme = "default";
          };
          dark = {
            name = "vicinae-dark";
            icon_theme = "default";
          };
        };
        # launcher_window = {
        #   opacity = 0.98;
        # };
        providers = {
          # Notice name difference. If declaring install and not installing manually, the name is different
          "system7/keepassxc" = {
            preferences = {
              # Declaring Secrets to a public repo is not good. See section below for secrets management
              database = "~/Documents/passwords.kdbx";
            };
          };
        };
      };
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        power-profile
        keepassxc
        pass
        # Extension names can be found in the link below, it's just the folder names
      ];
    };
  };
}
