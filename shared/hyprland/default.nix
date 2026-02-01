{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.package = pkgs.niri-unstable;
  systemd.user.services.niri-flake-polkit.enable = false;

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    niri.enable = true;
    uwsm.enable = true;

    # sway.enable = true;

    dconf.enable = true;
  };

  # nix.settings = {
  #   substituters = [];
  #   trusted-public-keys = [];

  environment.systemPackages = with pkgs; [
    libnotify
    networkmanagerapplet
  ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
