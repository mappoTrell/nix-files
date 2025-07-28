{
  # config,
  pkgs,
  # inputs,
  ...
}: {
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      c.editor.command = ["ghostty","-e","nvim", "{file}"]
    '';
    settings = {
      fonts.default_size = pkgs.lib.mkForce "16pt";

      tabs = {
        position = "left";
        show = "switching";
        width = "20%";
      };
    };
    keyBindings = {
      normal = {
        "pw" = "spawn --userscript qute-keepassxc --key 8964A9CE14358C0C4F2847F5A3F2C3CE7187B0F2";
        "h" = "scroll-px -25 0";
        "j" = "scroll-px 0 25";
        "k" = "scroll-px 0 -25";
        "l" = "scroll-px 25 0";
      };
      insert = {
        "<Alt-Shift-u>" = "spawn --userscript qute-keepassxc --key 8964A9CE14358C0C4F2847F5A3F2C3CE7187B0F2";
      };
    };
  };

  home.packages = [
    pkgs.rofi-wayland
    pkgs.gnupg
    pkgs.pinentry
  ];
}
