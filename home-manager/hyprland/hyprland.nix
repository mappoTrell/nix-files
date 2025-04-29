{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];
  home.packages = with pkgs; [
    hyprpolkitagent
    wl-clipboard
    grim
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = null;
    portalPackage = null;
    # set the flake package
    settings = {
      "$modifier" = "SUPER";
      bind = [
        "$modifier,Return,exec,uwsm app -- ghostty"
        "$modifier,SHIFT,K,exec,list-keybinds"
        "$modifier SHIFT,Return,exec,rofi-launcher"
        "$modifier SHIFT,W,exec,web-search"
        "$modifier ALT,W,exec,wallsetter"
        "$modifier SHIFT,N,exec,swaync-client -rs"
        "$modifier,W,exec,uwsm app -- brave"
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
        "$modifier,V,exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$modifier SHIFT,I,togglesplit,"
        "$modifier,F,fullscreen,"
        "$modifier SHIFT,F,togglefloating,"
        "$modifier ALT,F,workspaceopt, allfloat"
        "$modifier SHIFT,C,exit,"
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
        "ALT,Tab,cyclenext"
        "ALT,Tab,bringactivetotop"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        "$mod,F2, exec, night-shift" # Toggle night shift
      "$mod,F3, exec, night-shift" # Toggle night shift
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
  programs.waybar.enable = true;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      icon-theme = "Papirus";
      font = "JetBrainsMono Nerd Font Mono 12";
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
    };
    # plugins = with pkgs; [
    #   rofi-power-menu
    #   rofi-network-manager
    #   rofi-pulse-select
    # ];
  };
}
