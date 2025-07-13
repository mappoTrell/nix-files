{
  config,
  pkgs,
  inputs,
  ...
}: let
  border-size = config.theme.border-size;
  gaps-in = config.theme.gaps-in;
  gaps-out = config.theme.gaps-out;
  active-opacity = config.theme.active-opacity;
  inactive-opacity = config.theme.inactive-opacity;
  rounding = config.theme.rounding;
  blur = config.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
  background = "rgb(" + config.lib.stylix.colors.base00 + ")";
  active = "rgb(" + config.lib.stylix.colors.base0A + ")";
  lib = pkgs.lib;
in {
  imports = [
  ];
  home.packages = with pkgs; [
    hyprpolkitagent
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    wayland-utils
    wayland-protocols
    glib
    qt6ct
    wl-clipboard
    grim
    (pkgs.hyprshade.override {
      hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
    })
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = null;
    portalPackage = null;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprexpo
      hyprwinwrap
      hyprscrolling
    ];
    # set the flake package
    extraConfig = ''
      bind = SUPER, Delete, hyprexpo:expo, toggle

    '';
    settings = {
      plugin = {
        hyprscrolling = {
        };
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          # bg_col = rgb(111111);
          workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = true; # laptop touchpad
          gesture_fingers = 3; # 3 or 4
          gesture_distance = 300; # how far is the "max"
          gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };
      };
      general = {
        resize_on_border = true;
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        layout = "master";
        "col.inactive_border" = lib.mkForce background;
        "col.active_border" = lib.mkForce active;
      };

      render = {
        # explicit_sync = 1; # Change to 1 to disable
        # explicit_sync_kms = 1;
        direct_scanout = 0;
      };

      input = {
        kb_options = "compose:ralt";
      };
      decoration = {
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        rounding = rounding;
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
        blur = {
          enabled =
            if blur
            then "true"
            else "false";
          size = 18;
        };
      };
      "$modifier" = "SUPER";
      bind = [
        "$modifier,Return,exec,uwsm app -- ghostty"
        "$modifier SHIFT,K,exec,list-keybinds"
        "$modifier SHIFT,Return,exec, uwsm app -- walker"
        "$modifier SHIFT,W,exec,web-search"
        "$modifier ALT,W,exec,wallsetter"
        "$modifier SHIFT,N,exec,swaync-client -rs"
        "$modifier,W,exec,uwsm app -- brave  --password-store=basic"
        "$modifier,Y,exec,uwsm app -- ghostty -e yazi"
        "$modifier,E,exec,emopicker9000"
        "$modifier,S,exec,screenshootin"
        "$modifier,D,exec,discord"
        "$modifier,O,exec,obs"
        "$modifier,C,exec,hyprpicker -a"
        "$modifier,G,exec,gimp"
        "$modifier,T,exec,pypr toggle term"
        "$modifier,M,exec,pavucontrol"
        "$modifier,Q,killactive,"
        "$modifier,P,pseudo,"
        "$modifier,X, exec,powermenu"
        "$modifier,V,exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$modifier SHIFT,I,togglesplit,"
        "$modifier,F,fullscreen,"
        "$modifier SHIFT,F,togglefloating,"
        "$modifier ALT,F,workspaceopt, allfloat"
        "$modifier SHIFT,C,exec,quickmenu,"
        "$modifier SHIFT,left,movewindow,l"
        "$modifier SHIFT,right,movewindow,r"
        "$modifier SHIFT,up,movewindow,u"
        "$modifier SHIFT,down,movewindow,d"
        "$modifier SHIFT,h,movewindow,l"
        "$modifier SHIFT,l,movewindow,r"
        "$modifier SHIFT,k,movewindow,u"
        "$modifier SHIFT,j,movewindow,d"
        "$modifier ALT, left, swapwindow,l"
        "$modifier ALT, right, swapwindow,r"
        "$modifier ALT, up, swapwindow,u"
        "$modifier ALT, down, swapwindow,d"
        "$modifier ALT, 43, swapwindow,l"
        "$modifier ALT, 46, swapwindow,r"
        "$modifier ALT, 45, swapwindow,u"
        "$modifier ALT, 44, swapwindow,d"
        "$modifier,left,movefocus,l"
        "$modifier,right,movefocus,r"
        "$modifier,up,movefocus,u"
        "$modifier,down,movefocus,d"
        "$modifier,h,movefocus,l"
        "$modifier,l,movefocus,r"
        "$modifier,k,movefocus,u"
        "$modifier,j,movefocus,d"
        "$modifier,1,workspace,1"
        "$modifier,2,workspace,2"
        "$modifier,3,workspace,3"
        "$modifier,4,workspace,4"
        "$modifier,5,workspace,5"
        "$modifier,6,workspace,6"
        "$modifier,7,workspace,7"
        "$modifier,8,workspace,8"
        "$modifier,9,workspace,9"
        "$modifier,0,workspace,10"
        "$modifier SHIFT,SPACE,movetoworkspace,special"
        "$modifier,SPACE,togglespecialworkspace"
        "$modifier SHIFT,1,movetoworkspace,1"

        "$modifier SHIFT,2,movetoworkspace,2"
        "$modifier SHIFT,3,movetoworkspace,3"
        "$modifier SHIFT,4,movetoworkspace,4"
        "$modifier SHIFT,5,movetoworkspace,5"
        "$modifier SHIFT,6,movetoworkspace,6"
        "$modifier SHIFT,7,movetoworkspace,7"
        "$modifier SHIFT,8,movetoworkspace,8"
        "$modifier SHIFT,9,movetoworkspace,9"
        "$modifier SHIFT,0,movetoworkspace,10"
        "$modifier CONTROL,right,workspace,e+1"
        "$modifier CONTROL,left,workspace,e-1"
        "$modifier,mouse_down,workspace, e+1"
        "$modifier,mouse_up,workspace, e-1"
        # "ALT,Tab,cyclenext"
        "ALT,Tab , layoutmsg,swapwithmaster master"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        "$modifier,F2, exec, night-shift" # Toggle night shift
        "$modifier,F3, exec, night-shift" # Toggle night shift
      ];
      bindm = [
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        # "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
      ];
    };
  };
  programs.waybar = {
    enable = true;

    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = ["hyprland/workspaces"];
        modules-left = [
          "custom/startmenu"
          "custom/arrow6"
          "pulseaudio"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "idle_inhibitor"
          "custom/arrow7"
          "hyprland/window"
        ];
        modules-right = [
          "custom/arrow4"
          "custom/hyprbindings"
          "custom/arrow3"
          "custom/notification"
          "custom/arrow3"
          "custom/exit"
          "battery"
          "custom/arrow2"
          "tray"
          "custom/arrow1"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = '' {:L%H:%M}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && walker";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-keybinds";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
        "custom/arrow1" = {
          format = "";
        };
        "custom/arrow2" = {
          format = "";
        };
        "custom/arrow3" = {
          format = "";
        };
        "custom/arrow4" = {
          format = "";
        };
        "custom/arrow5" = {
          format = "";
        };
        "custom/arrow6" = {
          format = "";
        };
        "custom/arrow7" = {
          format = "";
        };
      }
    ];
    style =
      # concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: 14px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: #${config.lib.stylix.colors.base00};
          color: #${config.lib.stylix.colors.base05};
        }
        #workspaces button {
          padding: 0px 5px;
          background: transparent;
          color: #${config.lib.stylix.colors.base04};
        }
        #workspaces button.active {
          color: #${config.lib.stylix.colors.base08};
        }
        #workspaces button:hover {
          color: #${config.lib.stylix.colors.base08};
        }
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base05};
          border-radius: 12px;
        }
        tooltip label {
          color: #${config.lib.stylix.colors.base05};
        }
        #window {
          padding: 0px 10px;
        }
        #pulseaudio, #cpu, #memory, #idle_inhibitor {
          padding: 0px 10px;
          background: #${config.lib.stylix.colors.base04};
          color: #${config.lib.stylix.colors.base00};
        }
        #custom-startmenu {
          color: #${config.lib.stylix.colors.base02};
          padding: 0px 14px;
          font-size: 20px;
          background: #${config.lib.stylix.colors.base0B};
        }
        #custom-hyprbindings, #network, #battery,
        #custom-notification, #custom-exit {
          background: #${config.lib.stylix.colors.base0F};
          color: #${config.lib.stylix.colors.base00};
          padding: 0px 10px;
        }
        #tray {
          background: #${config.lib.stylix.colors.base02};
          color: #${config.lib.stylix.colors.base00};
          padding: 0px 10px;
        }
        #clock {
          font-weight: bold;
          padding: 0px 10px;
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0E};
        }
        #custom-arrow1 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base0E};
          background: #${config.lib.stylix.colors.base02};
        }
        #custom-arrow2 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base02};
          background: #${config.lib.stylix.colors.base0F};
        }
        #custom-arrow3 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0F};
        }
        #custom-arrow4 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base0F};
          background: transparent;
        }
        #custom-arrow6 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base0B};
          background: #${config.lib.stylix.colors.base04};
        }
        #custom-arrow7 {
          font-size: 24px;
          color: #${config.lib.stylix.colors.base04};
          background: transparent;
        }
      ''
      # ]
      ;
  };
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland-unwrapped;
  #   extraConfig = {
  #     modi = "drun,filebrowser,run";
  #     show-icons = true;
  #     icon-theme = "Papirus";
  #     font = "JetBrainsMono Nerd Font Mono 12";
  #     drun-display-format = "{icon} {name}";
  #     display-drun = " Apps";
  #     display-run = " Run";
  #     display-filebrowser = " File";
  #   };
  #   # plugins = with pkgs; [
  #   #   rofi-power-menu
  #   #   rofi-network-manager
  #   #   rofi-pulse-select
  #   # ];
  # };
}
