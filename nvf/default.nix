{pkgs, ...}:
{

  config.vim = {
    languages = {
      nix.enable = true;
      zig.enable = true;
      html.enable = true;
      ts.enable = true;
      python.enable = true;
      clang.enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };

    fzf-lua = {
      enable = true;
    };

    mini = {
      ai.enable = true;
      surround.enable = true;
      basics.enable = true;
      files.enable = true;
      bracketed.enable = true;
statusline.enable = true;
      tabline.enable = true;


    };

    lsp = { 
      enable = true;
      inlayHints.enable = true;
      formatOnSave = true;
    };
treesitter.enable = true;

navigation.harpoon.enable = true;

    binds.whichKey.enable =true ;

    visuals.indent-blankline.enable = true;

  };
}
