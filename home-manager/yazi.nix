{
  pkgs,
  inputs,
  ...
}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "...";
    hash = "sha256-...";
  };
in {
  programs.yazi = {
    plugins.bunny = "${inputs.bunny-yazi}";
    initLua = ''
          require("bunny"):setup({
        hops = {
          { key = "r",          path = "/",                                    },
          { key = "v",          path = "/var",                                 },
          { key = "t",          path = "/tmp",                                 },
          { key = "n",          path = "/nix/store",     desc = "Nix store"    },
          { key = { "h", "h" }, path = "~",              desc = "Home"         },
          { key = { "h", "m" }, path = "~/Music",        desc = "Music"        },
          { key = { "h", "d" }, path = "~/Documents",    desc = "Documents"    },
          { key = { "h", "k" }, path = "~/Desktop",      desc = "Desktop"      },
          { key = "c",          path = "~/.config",      desc = "Config files" },
          { key = { "l", "s" }, path = "~/.local/share", desc = "Local share"  },
          { key = { "l", "b" }, path = "~/.local/bin",   desc = "Local bin"    },
          { key = { "l", "t" }, path = "~/.local/state", desc = "Local state"  },
          { key = { "e", "s" }, path = "/run/media/xelix/T7_Shield/", desc = "external T7_Shield"  },
          -- key and path attributes are required, desc is optional
        },
        desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
        notify = false, -- Notify after hopping, default is false
        fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
      })
    '';
    keymap.manager.prepend_keymap = [
      {
        on = ";";
        run = "plugin bunny";
        desc = "Start bunny.yazi";
      }
    ];
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
      manager = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
  };
}
