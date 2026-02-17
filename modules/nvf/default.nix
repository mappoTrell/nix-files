{inputs,...}: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };
  
  perSystem = {pkgs,...}: {
    packages.my-nvf = (inputs.nvf.lib.neovimConfiguration {
      pkgs,
      modules = [
        ./config.nix
      ];
    }).neovim;
  }

}