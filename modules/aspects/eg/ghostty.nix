{
  eg.ghostty.nixos = {pkgs, ...}: {
    services.xserver.enable = true;

    services.displayManager.ly = {
      enable = true;
      settings = {
        vi_mode = false;
      };
    };

    systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
  };
}
