{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./yazi.nix
    ./hyprland
    ./starship.nix
    ../shared/stylix
    # inputs.anyrun.homeManagerModules.default
    # ./arduino-port/arduino.nix
    # "${inputs.kickstart-nixvim}/nixvim.nix"
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xelix";
  home.homeDirectory = "/home/xelix";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #inputs.editect.defaultPackage.x86_64-linux
    pkgs.kdePackages.krohnkite

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    pkgs.kdePackages.filelight
    pkgs.kdePackages.krdp
    pkgs.kdePackages.kdeconnect-kde
    pkgs.wl-clipboard
    pkgs.godot_4_3
    pkgs.scrcpy
    pkgs.qtscrcpy
    #pkgs.davinci-resolve
    pkgs.vlc
    #pkgs.qgis
    pkgs.libreoffice-fresh
    pkgs.zig
    pkgs.zoxide
    (pkgs.callPackage ./arduino-port {
      inp = inputs.ard-port;
      withGui = true;
    })
    pkgs.lutris
    pkgs.rose-pine-cursor
  ];
  # '')

  # home.pointerCursor = {
  #   enable = true;
  #   package = pkgs.rose-pine-cursor;
  #   name = "BreezeX-RoséPine";
  # };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-size = 20;
      cursor-theme = pkgs.lib.mkForce "BreezeX-RosePine-Linux";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    force = true;
    text = ''
      [filechooser]
      cmd=filechooser
    '';
  };

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

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # theme = "tokyonight";
      # font-size = 16;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/xelix/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    SSH_AUTH_SOCK = /run/user/1000/ssh-agent;
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      yazi_test = {
        body =
          /*
          fish
          */
          ''            set tmp (mktemp -t "yazi-cwd.XXXXXX")
                          yazi $argv --cwd-file="$tmp"
                          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                            builtin cd -- "$cwd"
                          end
                          rm -f -- "$tmp"'';
        onEvent = "y";
      };
    };
  };
  services.ssh-agent.enable = true;

  # programs.nixvim = {
  #   enable = true;
  #
  #   #colorschemes.catppuccin.enable =  false;
  #   # imports = [ inputs.Neve.nixvimModule ];
  #
  #   opts = {
  #     #suda_smart_edit = 1;
  #   };
  #
  #   plugins.vim-suda = {
  #     enable = true;
  #   };
  #
  #   plugins.toggleterm = {
  #     enable = true;
  #     settings.open_mapping = "[[<Leader>T]]";
  #     settings.insert_mappings = false;
  #   };
  # };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    # font.name = "FiraCode Nerd Font";
  };

  programs.lazygit.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
