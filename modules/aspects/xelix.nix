{
  den,
  eg,
  ...
}: {
  den.ctx.hm-host.includes = [
    ({host, ...}: {nixos.home-manager.backupFileExtension = "hm-back";})
  ];

  den.aspects.xelix = {
    # Alice can include other aspects.
    # For small, private one-shot aspects, use let-bindings like here.
    # for more complex or re-usable ones, define on their own modules,
    # as part of any aspect-subtree.

    includes = let
      # hack for nixf linter to keep findFile :/
      unused = den.lib.take.unused __findFile;
      __findFile = unused den.lib.__findFile;
      # shell = "fish";

      customEmacs.homeManager = {pkgs, ...}: {
        programs.emacs.enable = true;
        programs.emacs.package = pkgs.emacs30-nox;
      };
    in [
      # from local bindings.
      customEmacs
      # eg.niri

      # from the aspect tree, cooper example is defined bellow
      den.aspects.cooper
      den.aspects.foo
      # den.aspects.setHost
      eg.niri
      eg.ghostty
      eg.nh
      eg.gaming
      <eg/dev/zellij>
      <eg/dev/zoxide>
      <eg/dev/direnv>
      <eg/dev/git>
      <eg/qutebrowser>
      # eg.autologin
      # den included batteries that provide common configs.
      <den/primary-user> # alice is admin always.
      (<den/user-shell> "fish")

      # ({user, ...}: <den/user-shell> user.shell) # default user shell
      <eg/theming/theme>
    ];

    # Alice configures NixOS hosts it lives on.
    nixos = {pkgs, ...}: {
      users.users.xelix.packages = [pkgs.vim];
      nix.settings.experimental-features = ["nix-command" "flakes"];
      # home-manager.backupFileExtension = "hm-back";

      environment.systemPackages = [
        pkgs.kdePackages.partitionmanager
        pkgs.linux-wifi-hotspot
      ];

      xdg.portal.enable = true;
      xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
      qt.enable = true;
      services.gvfs.enable = true;
      # users.users.xelix.initialPassword = "123";
    };

    # Alice home-manager.
    homeManager = {
      pkgs,
      self',
      ...
    }: {
      programs.fish.enable = true;
      home.packages = [
        pkgs.htop
        pkgs.neovim
        self'.packages.my-nvf
        # pkgs.git
        pkgs.firefox
        pkgs.kdePackages.dolphin
        pkgs.nautilus
        pkgs.lazygit
        # pkgs.evince
        pkgs.kdePackages.okular
        # pkgs.kdePackages.plasma-workspace
      ];

      programs.superfile.enable = true;

      services.syncthing = {
        enable = true;
        settings.devices = {
          nixos = {
            id = "WL5DIUM-YMG3AOC-R37CXVI-QQ3FN7F-BHWDYAZ-B7FWKWZ-YJIUBAT-5LU4PAI";
            name = "desktop";
          };
        };
      };

      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
          "application/pdf" = ["org.kde.okular.desktop"];
        };
        desktopEntries = {
          my-custom-app = {
            name = "superfile";
            comment = "superfile";
            exec = "ghostty -e superfile";
            # icon = "${pkgs.my-custom-app}/share/icons/hicolor/256x256/apps/my-custom-app.png";
            terminal = false;
            categories = ["Utility"];
          };
        };
        # mime.defaultApplications = {
        #   "application/pdf" = ["org.pwmt.zathura.desktop"];
        # };
      };
    };

    # <user>.provides.<host>, via eg/routes.nix
    # provides.to-hosts = {host, ...}: {
    #   nixos.programs.nh.enable = host.name == "xelix";
    # };
  };

  # This is a context-aware aspect, that emits configurations
  # **anytime** at least the `user` data is in context.
  # read more at https://vic.github.io/den/context-aware.html
  den.aspects.cooper = {user, ...}: {
    nixos.users.users.${user.userName}.description = "Felix Scherb";
  };
  den.aspects.foo = {user, ...} @ context: (builtins.trace context {
    user = user.user-params;
  });
  # den.aspects.setHost = {host, ...}: {
  #   networking.hostName = host.hostName;
  # };
}
