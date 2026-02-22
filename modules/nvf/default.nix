{
  inputs,
  den,
  ...
}: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  den.default.includes = [
    den._.self'
    den._.inputs'
  ];

  perSystem = {pkgs, ...}: {
    packages.my-nvf =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = pkgs;

        modules = [
          {
            config.vim = {
              extraPackages = [
                pkgs.lua
                pkgs.lazygit
                pkgs.fd
                pkgs.ripgrep
                pkgs.zoxide
                pkgs.wl-clipboard
                pkgs.cliphist

                # pkgs.arduino-language-server
                # pkgs.arduino-cli
                # pkgs.clang-tools
              ];

              theme.enable = true;
              theme.name = "rose-pine";
              theme.style = "main";
              theme.transparent = true;

              languages = {
                enableFormat = true;
                nix.enable = true;
                nix.extraDiagnostics.enable = true;

                zig = {
                  enable = true;
                  lsp.enable = true;
                  treesitter.enable = true;
                };

                html.enable = true;
                ts.enable = true;
                python.enable = true;
                clang.enable = true;
              };

              keymaps = [
                {
                  key = "<leader>bc";
                  mode = "n";
                  desc = "close buffer";
                  # silent = true;
                  action = "<cmd>bdelete<CR>";
                }
                # {
                #   key = "gd";
                #   mode = "n";
                #   silent = true;
                #   action = "<leader>lgd";
                # }
                {
                  key = "<leader>e";
                  mode = "n";
                  desc = "explorer";
                  lua = true;
                  # silent = true;
                  action = "Snacks.explorer.open";
                }
                {
                  key = "<leader><Space>";
                  mode = "n";
                  desc = "files";
                  lua = true;
                  # silent = true;
                  action = "Snacks.picker.smart";
                }
                {
                  key = "<leader>/";
                  mode = "n";
                  desc = "live grep";
                  lua = true;
                  # silent = true;
                  action = "Snacks.picker.grep";
                }
                # {
                #   key = "<leader>ec";
                #   mode = "n";
                #   # silent = true;
                #   action = ":e %:h<CR>";
                # }
              ];

              # autocomplete.nvim-cmp = {
              #   enable = true;
              #   setupOpts.completion.completeopt = "menu,menuone,noselect";
              #   sources = {
              #     buffer = "[Buffer]";
              #     path = "[Path]";
              #   };
              # };

              autocomplete.blink-cmp = {
                enable = true;

                friendly-snippets.enable = true;
                setupOpts = {
                  keymap.preset = "super-tab";
                  cmdline.keymap.preset = "default";
                  cmdline.sources = null;
                  cmdline.completion.menu.auto_show = true;

                  signature.enabled = true;

                  sources.default = [
                    "lsp"
                    "path"
                    "snippets"
                    "buffer"
                    "omni"
                    "cmdline"
                  ];
                  sources.providers = {
                    lsp = {
                      fallbacks = ["buffer"];
                    };
                  };
                  completion.accept.auto_brackets.enabled = false;
                };
              };

              # fzf-lua = {
              #   enable = true;
              #   profile = "telescope";
              # };
              # telescope.enable = true;

              session.nvim-session-manager = {
                enable = true;
                setupOpts.autoload_mode = "CurrentDir";
              };

              utility.snacks-nvim = {
                enable = true;
                setupOpts = {
                  dashboard = {
                    enable = true;
                    sections = [
                      {section = "header";}
                      {
                        icon = " ";
                        title = "Keymaps";
                        section = "keys";
                        indent = 2;
                        padding = 1;
                      }
                      {
                        icon = " ";
                        title = "Recent Files";
                        section = "recent_files";
                        indent = 2;
                        padding = 1;
                      }
                      {
                        icon = " ";
                        title = "Projects";
                        section = "projects";
                        indent = 2;
                        padding = 1;
                      }
                    ];
                  };
                  init.enable = true;
                  toggle.enable = true;
                  explorer = {
                    enable = true;
                    auto_close = true;

                    jump.close = true;
                  };
                  picker = {
                    enable = true;
                    sources.explorer = {
                      auto_close = true;
                    };
                  };
                  input.enable = true;
                  lazygit.enable = true;
                  indent = {
                    enable = true;
                    animate.enabled = false;
                  };
                  image.enable = true;
                  words.enable = true;
                  notifier.enable = true;
                  # scroll.enable = true;
                  statuscolumn.enable = true;
                };
              };

              mini = {
                #   #   ai.enable = true;
                #   #   surround.enable true;
                #   #   basics.setupOpts = {
                #   #       options = {
                #   #           basic = true;
                #   #           extra_ui = true;
                #   #         };e;
                statusline.enable = true;
                tabline.enable = true;
                icons.enable = true;
                extra.enable = true;
                # sessions.enable = true;
                pairs.enable = true;
              };
              #
              extraPlugins = {
                # mini-sessions = {
                #   package = "mini-sessions";
                #   setup = "require('mini.sessions').setup({
                #           autoread = true,
                #         })";
                # };
                # auto-session = {
                #   package = pkgs.vimPlugins.auto-session;
                #   setup = "require('auto-session').setup {}";
                # };
                #
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
                  setup = "require('mini.surround').setup(
              {
              mappings = {
              add = 'gsa', -- Add surrounding in Normal and Visual modes
              delete = 'gsd', -- Delete surrounding
              find = 'gsf', -- Find surrounding (to the right)
              find_left = 'gsF', -- Find surrounding (to the left)
              highlight = 'gsh', -- Highlight surrounding
              replace = 'gsr', -- Replace surrounding
              update_n_lines = 'gsn', -- Update `n_lines`

              suffix_last = 'l', -- Suffix to search with  prev  method
              suffix_next = 'n', -- Suffix to search with  next  method
              },
              }
              )";
                };
                #     mini-files = {
                #       package = "mini-files";
                #       setup = "require('mini.files').setup()";
                #     };
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
              };
              treesitter.enable = true;

              navigation.harpoon = {
                enable = true;
                setupOpts.defaults.save_on_toggle = true;
                setupOpts.defaults.sync_on_ui_close = true;
              };

              binds.whichKey.enable = true;
              utility.sleuth.enable = true;
              # visuals.indent-blankline.enable = true;
            };
          }
          # (./config.nix {inherit pkgs};)
        ];
      }).neovim;
    packages.hello = pkgs.hello;
  };
}
