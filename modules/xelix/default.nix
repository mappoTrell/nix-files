{


  xelix.packages = {
    pkgs,
    inputs,
    ...
  }: {
    home.packages = with pkgs; [
      kdePackages.krohnkite
      antigravity-fhs
      kdePackages.filelight
      kdePackages.krdp
      kdePackages.kdeconnect-kde
      wl-clipboard
      godot_4_3
      jujutsu
      scrcpy
      qtscrcpy
      vlc
      libreoffice-fresh
      zig_0_15
      zoxide
      (pkgs.callPackage ../../home-manager/arduino-port {
        inp = inputs.ard-port;
        withGui = true;
      })
      lutris
      rose-pine-cursor
      protonvpn-gui
      qgis
    ];
  };

  xelix.shell = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      functions = {
        yazi_test = {
          body = ''
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            yazi $argv --cwd-file="$tmp"
            if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              builtin cd -- "$cwd"
            end
            rm -f -- "$tmp"
          '';
          onEvent = "y";
        };
      };
    };

    programs.sesh.enable = true;
    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xelix.development = {pkgs, ...}: {
    programs.lazygit.enable = true;
  };

  xelix.terminal = {pkgs, ...}: {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
    };

    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {};
    };
  };

  xelix.plasma = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];

    programs.plasma = {
      enable = true;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
      };

      shortcuts = {
        "services/ghostty.desktop"."_launch" = "Ctrl+ALt+t";
        "services/org.kde.konsole.desktop"."_launch" = [];
      };
    };

    qt.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-size = 20;
        cursor-theme = pkgs.lib.mkForce "BreezeX-RosePine-Linux";
      };
    };
  };

  xelix.nvidia-env = {...}: {
    wayland.windowManager.hyprland.settings.env = [
      "LIBVA_DRIVER_NAME , nvidia"
      "XDG_SESSION_TYPE , wayland"
      "M_BACKEND , nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME , nvidia"
      "NIXOS_OZONE_WL , 1"
      "__GL_GSYNC_ALLOWED , 1"
      "__GL_VRR_ALLOWED , 1"
      "WLR_DRM_NO_ATOMIC , 1"
      "NVD_BACKEND , direct"
      "MOZ_ENABLE_WAYLAND , 1"
    ];
  };

  xelix.file-chooser = {...}: {
    xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=filechooser
      '';
    };
  };
}

