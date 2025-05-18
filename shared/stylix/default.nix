{
  lib,
  pkgs,
  config,
  ...
}: {
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 20;
      gaps-in = 3;
      gaps-out = 3 * 2;
      active-opacity = 0.96;
      inactive-opacity = 0.92;
      blur = true;
      border-size = 3;
      animation-speed = "fast"; # "fast" | "medium" | "slow"
      fetch = "none"; # "nerdfetch" | "neofetch" | "pfetch" | "none"
      textColorOnWallpaper =
        config.lib.stylix.colors.base01; # Color of the text displayed on the wallpaper (Lockscreen, display manager, ...)

      bar = {
        # Hyprpanel
        position = "top"; # "top" | "bottom"
        transparent = true;
        transparentButtons = false;
        floating = true;
      };
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    # base16Scheme = {
    #   base00 = "09090B"; # Default Background
    #   base01 =
    #     "1c1e1f"; # Lighter Background (Used for status bars, line number and folding marks)
    #   base02 = "313244"; # Selection Background
    #   base03 = "45475a"; # Comments, Invisibles, Line Highlighting
    #   base04 = "585b70"; # Dark Foreground (Used for status bars)
    #   base05 = "cdd6f4"; # Default Foreground, Caret, Delimiters, Operators
    #   base06 = "f5e0dc"; # Light Foreground (Not often used)
    #   base07 = "b4befe"; # Light Background (Not often used)
    #   base08 =
    #     "f38ba8"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    #   base09 =
    #     "fab387"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    #   base0A = "f9e2af"; # Classes, Markup Bold, Search Text Background
    #   base0B = "a6e3a1"; # Strings, Inherited Class, Markup Code, Diff Inserted
    #   base0C =
    #     "94e2d5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
    #   base0D =
    #     "c5afd4"; # Functions, Methods, Attribute IDs, Headings, Accent color
    #   base0E =
    #     "cba6f7"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
    #   base0F =
    #     "f2cdcd"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    # base00= "#232136";
    # base01= "#2a273f";
    # base02= "#393552";
    # base03= "#6e6a86";
    # base04= "#908caa";
    # base05= "#e0def4";
    # base06= "#56526e";
    # base07= "#56526e";
    # base08= "#eb6f92";
    # base09= "#f6c177";
    # base0A= "#ea9a97";
    # base0B= "#3e8fb0";
    # base0C= "#9ccfd8";
    # base0D= "#c4a7e7";
    # base0E= "#f6c177";
    # base0F= "#56526e";
    #   };

    cursor = {
      name = "rose-pine-cursor";
      package = with pkgs; rose-pine-hyprcursor;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 18;
      };
    };

    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/refs/heads/main/app/static/wallpapers/vanilla_pink_purple.png";
      sha256 = "sha256-JJIsoC3MaUB378RfogU7BDuXOuy7Vk048CwfyNe9FYg=";
    };
  };
}
