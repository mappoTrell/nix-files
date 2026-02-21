{inputs, ...}: {
  flake-file.inputs = {
    zellij-command-hook = {
      url = "github:Zach-Mac/zellij-command-hook";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  eg.dev._.zellij.homeManager = {
    user,
    host,
    pkgs,
    ...
  }: {
    home.packages = [
      inputs."zellij-command-hook".packages.${host.system}.default
    ];
    programs.zellij = {
      enable = true;

      eableFishIntegration = user.conf.shell == "fish";
      enableBashIntegration = user.conf.shell == "bash";
      enableZshIntegration = user.conf.shell == "zsh";
    };

    xdg.configFile."zellij/config.kdl".source = ./zellij.kdl;
    xdg.configFile."zellij/plugins/zsm.wasm".source = pkgs.fetchurl {
      url = "https://github.com/liam-mackie/zsm/releases/download/v0.4.1/zsm.wasm";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };
  };
}
