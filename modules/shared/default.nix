{
  shared.base-system =
    { pkgs, lib, ... }:
    {
      # Basic system configuration
      nix.settings = {
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://walker.cachix.org"
          "https://walker-git.cachix.org"
        ];
        trusted-substituters = ["https://devenv.cachix.org"];
        trusted-public-keys = [
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
          "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
        ];
        experimental-features = ["nix-command" "flakes"];
      };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.memtest86.enable = true;
      boot.binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];

      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = [pkgs.wayland];

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/user/my-nixos-config";
      };

      networking.networkmanager.enable = true;
      time.timeZone = "Europe/Berlin";

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };

      services.xserver.enable = true;
      services.displayManager.ly = {
        enable = true;
        settings = { vi_mode = false; };
      };
      systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
      services.desktopManager.plasma6.enable = true;

      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.rasdaemon.enable = true;

      services.printing.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      services.xserver.xkb = { layout = "us"; variant = ""; };
      console.keyMap = "us";

      home-manager.extraSpecialArgs = {inherit inputs;};
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      programs.nix-index-database.comma.enable = true;
      programs.kdeconnect.enable = true;
      programs.seahorse.enable = true;
      programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        config.credential.helper = "libsecret";
      };

      nixpkgs.config.allowUnfree = true;

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        config = {
          hyprland = { default = ["gtk" "hyprland"]; };
        };
      };
      xdg.portal.config.common.default = "*";
      xdg.mime.defaultApplications = {
        "application/pdf" = "org.kde.okular.desktop";
      };

      programs.virt-manager.enable = true;
      users.groups.libvirtd.members = ["xelix"];
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
      virtualisation.libvirtd.qemu.vhostUserPackages = [pkgs.virtiofsd];

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };
      virtualisation.waydroid.enable = true;

      programs.firefox.enable = true;
      programs.wshowkeys.enable = true;

      environment.sessionVariables = { EDITOR = "nvim"; };

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      services.pcscd.enable = true;

      services.udev.extraRules = ''
        # Rules for Oryx web flashing and live training
        KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

        # Legacy rules for live training over webusb (Not needed for firmware v21+)
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

        # Wally Flashing rules for Ergodox EZ
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

        # Keymapp / Wally Flashing rules for Moonlander and Planck EZ
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
        # Keymapp Flashing rules for Voyager
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
      '';

      networking.firewall.enable = true;
    };

  shared.packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        alsa-tools
        quickemu
        samba
        bottles
        keymapp
        xorg.xmessage
        ripgrep
        kitty
        keepassxc
        zls_0_15
        brave
        kdePackages.partitionmanager
        bluez
        yubikey-manager
        yubikey-personalization
        libclang
        clinfo
        brightnessctl
        playerctl
        pavucontrol
        (pass.withExtensions (ext: with ext; [pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb]))
        rpi-imager
        iwmenu
        bzmenu
        distrobox
      ];

      fonts.packages = [
        pkgs.nerd-fonts._0xproto
        pkgs.nerd-fonts.fira-code
      ];
    };

  shared.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      programs.gamescope = {
        enable = true;
        capSysNice = true;
        env = { DXVK_HDR = "1"; };
        args = [
          "--hdr-enabled"
          "--adaptive-sync"
          "-r 144"
          "--hdr-itm-enable"
        ];
      };
    };

  shared.virtualization =
    { pkgs, ... }:
    {
      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = ["xelix"];
    };

  shared.stylix-theme =
    { pkgs, config, ... }:
    {
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
          animation-speed = "fast";
          fetch = "none";
          textColorOnWallpaper = config.lib.stylix.colors.base01;
          bar = {
            position = "top";
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
            package = pkgs.noto-fonts-color-emoji;
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
    };
}