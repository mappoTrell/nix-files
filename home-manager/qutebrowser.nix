{
  # config,
  pkgs,
  # inputs,
  ...
}: {
  programs.qutebrowser = {
    enable = true;
    settings = {
      tabs.position = "left";
    };
    keyBindings = {
      normal = {
        "pw" = "spawn --userscript qute-keepassxc --key ABC1234";
      };
      insert = {
        "<Alt-Shift-u>" = "spawn --userscript qute-keepassxc --key ABC1234";
      };
    };
  };

  home.packages = [
    pkgs.rofi-wayland
    pkgs.gnupg
  ];
}
