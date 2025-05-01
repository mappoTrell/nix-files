{
  config,
  pkgs,
  inputs,
  ...
}: {
   imports = [
    ../home-manager/home.nix
  ];
    wayland.windowManager.hyprland = {
            settings.env = [
              "LIBVA_DRIVER_NAME , nvidia" # Hardware video acceleration
              "XDG_SESSION_TYPE , wayland" # Force ayland
              "M_BACKEND , nvidia-drm" # Graphics backend for Wayland
              "__GLX_VENDOR_LIBRARY_NAME , nvidia" # Use Nvidia driver for GLX
              "WLR_NO_HARDWARE_CURSORS , 1" # Fix for cursors on Wayland
              "NIXOS_OZONE_WL , 1" # Wayland support for Electron apps
              "__GL_GSYNC_ALLOWED , 1" # Enable G-Sync if available
              "__GL_VRR_ALLOWED , 1" # Enable VRR (Variable Refresh Rate)
              "WLR_DRM_NO_ATOMIC , 1" # Fix for some issues with Hyprland
              "NVD_BACKEND , direct" # Configuration for new driver
              "MOZ_ENABLE_WAYLAND , 1" # Wayland support for Firefox
            ];
          };
}

