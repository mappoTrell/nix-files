{
  config,
  pkgs,
  ...
}: let
  wrap = pkgs.writeShellApplication {
    name = "wrap";
    text = ''
      "$@"
    '';
  };
in {
  home.packages = [
    wrap
  ];
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile."zellij/config.kdl".source = ./zellij.kdl;
  xdg.configFile."zellij/plugins/zsm.wasm".source = pkgs.fetchurl {
    url = "https://github.com/liam-mackie/zsm/releases/download/v0.4.0/zsm.wasm";
    hash = "sha256-ttNKilN2FtCDXXeTG44Rif/fY85g3up7xRzfC6yzd+g=";
  };
}
