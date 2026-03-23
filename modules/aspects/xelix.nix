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
      ];

      xdg.portal.enable = true;
      xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
      qt.enable = true;
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
        pkgs.lazygit
      ];
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
