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

  perSystem = {pkgs, ...}: let
    choiceScript = target:
      pkgs.writeShellScriptBin "find_script" ''
        path_to_executable=$(which ${target})
         if [ -x "$path_to_executable" ] ; then
              exec ${target} "$@"
        fi
        exec ${pkgs.lib.getExe pkgs.${target}} "$@"
      '';
  in {
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
                pkgs.zls

                # pkgs.arduino-language-server
                # pkgs.arduino-cli
                # pkgs.clang-tools
              ];

              theme.enable = true;
              theme.name = "rose-pine";
              theme.style = "main";
              theme.transparent = true;

              lsp.servers."zls".cmd = pkgs.lib.mkForce ["${pkgs.lib.getExe (choiceScript "zls")}"];

              languages = {
                # enableTreesitter = ["lua"];

                enableFormat = true;
                nix.enable = true;
                nix.extraDiagnostics.enable = true;
                nix.treesitter.enable = true;

                lua.enable = true;

                zig = {
                  enable = true;
                  lsp.enable = true;
                  # lsp.package = ["];
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
              snippets.luasnip = {
                enable = true;
                customSnippets.snipmate = {
                  zig = [
                    {
                      trigger = "sc";
                      body = ".{$1},";
                    }
                    {
                      trigger = "ss";
                      body = ".{$1};";
                    }
                  ];
                };
              };

              autocomplete.blink-cmp = {
                enable = true;

                friendly-snippets.enable = true;
                setupOpts = {
                  keymap.preset = "super-tab";
                  cmdline.keymap.preset = "default";
                  cmdline.sources = null;
                  cmdline.completion.menu.auto_show = true;

                  completion.accept.auto_brackets.enable = false;

                  snippets = {preset = "luasnip";};

                  signature.enable = true;

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
                  setup =
                    /*
                    lua
                    */
                    ''
                        local spec = require('mini.ai').gen_spec
                        require('mini.ai').setup({

                        custom_textobjects = {
                          F = spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                          S = spec.pair('.{', '}', {type = 'non-balanced'}),
                          e = spec.function_call({
                            name_pattern = '[@%w+|%w+((%.%w+)+)?]',  -- Matches @ followed by word characters or just word characters, with an opening parenthesis
                            include_delimiter = true,          -- Include the delimiter in the selection
                          }),
                          o = spec.treesitter({
                            a = { '@class.outer', '@class.outer' },
                            i = { '@class.inner', '@class.inner' },
                          })
                        },
                      })'';
                };

                mini-basics = {
                  package = "mini-basics";
                  setup = "require('mini.basics').setup()";
                };
                mini-surround = {
                  package = "mini-surround";
                  setup =
                    /*
                    lua
                    */
                    ''
                            require('mini.surround').setup({
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
                      )'';
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
                otter-nvim.enable = true;
              };
              treesitter.enable = true;
              treesitter.textobjects.enable = true;
              treesitter.context.enable = true;
              treesitter.highlight.enable = true;
              treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                regex
                kdl
                lua
                bash
                python
                nix
              ];
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
