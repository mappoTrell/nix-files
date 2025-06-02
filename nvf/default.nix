{pkgs, ...}: {
  config.vim = {
    extraPackages = [
      pkgs.arduino-language-server
      pkgs.arduino-cli
      pkgs.clang-tools
    ];

    theme.enable = true;
    theme.name = "rose-pine";
    theme.style = "moon";

    languages = {
      enableFormat = true;
      nix.enable = true;
      nix.extraDiagnostics.enable = true;

      zig.enable = true;
      html.enable = true;
      ts.enable = true;
      python.enable = true;
      clang.enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;

      friendly-snippets.enable = true;
      setupOpts = {
        keymap.preset = "super-tab";
        signature.enabled = true;
        completion.accept.auto_brackets.enabled = false;
      };
    };

    # fzf-lua = {
    #   enable = true;
    #   profile = "telescope";
    # };
    telescope.enable = true;

    mini = {
      #   ai.enable = true;
      #   surround.enable = true;
      #   basics.enable = true;
      #   basics.setupOpts = {
      #       options = {
      #           basic = true;
      #           extra_ui = true;
      #         };
      #       mappings = {
      #           basic = true;
      #         };
      #     };
      #   files.enable = true;
      #   bracketed.enable = true;
      statusline.enable = true;
      tabline.enable = true;
      icons.enable = true;
      extra.enable = true;
      #   pairs.enable = true;
    };

    extraPlugins = {
      mini-ai = {
        package = "mini-ai";
        setup = "require('mini.ai').setup()";
      };
      mini-basics = {
        package = "mini-basics";
        setup = "require('mini.basics').setup()";
      };
      mini-surround = {
        package = "mini-surround";
        setup = "require('mini.surround').setup()";
      };
      mini-files = {
        package = "mini-files";
        setup = "require('mini.files').setup()";
      };
      mini-bracketed = {
        package = "mini-bracketed";
        setup = "require('mini.bracketed').setup()";
      };
      mini-pairs = {
        package = "mini-pairs";
        setup = "require('mini.pairs').setup()";
      };
    };

    lsp = {
      enable = true;
      inlayHints.enable = true;
      formatOnSave = true;

      servers = {
        "*" = {
          root_markers = [".git"];
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
        };

        # "clangd" = {
        #   filetypes = ["c" "arduino"];
        # };
        "arduino" = {
          filetypes = ["arduino"];

          capabilities = {
            textDocument = {
              semanticTokens = null;
            };
            workspace = {
              semanticTokens = null;
            };
          };
          enabled = true;
          cmd = [
            "arduino-language-server"
            # "${pkgs.arduino-language-server}/bin/arduino-language-server"
            # "-clangd"      "${pkgs.clang-tools}/bin/clangd"
            # "-clangd"      "/nix/store/06gf7f983rjm28pmycy732hdj4i7x0v8-clang-tools-19.1.7/bin/clangd"
            # "-cli"         "${pkgs.arduino-cli}/bin/arduino-cli"
            "-cli-config"
            "/home/xelix/.arduinoIDE/arduino-cli.yaml"
            "-fqbn"
            "esp8266:esp8266:nodemcuv2"
          ];
        };
      };
    };
    treesitter.enable = true;

    navigation.harpoon.enable = true;

    binds.whichKey.enable = true;
    utility.sleuth.enable = true;
    visuals.indent-blankline.enable = true;
  };
}
