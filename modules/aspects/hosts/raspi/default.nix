{
  den,
  eg,
  __findFile,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
    };
  };

  den.aspects.admin = {
    user = {
      pkgs,
      config,
      ...
    }: {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      # Allow the graphical user to login without password
      initialHashedPassword = "";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE67zi95Ni36JuP9QLqM0WhRwXHkhoZsjSsKnjraBSX8"
      ];
    };

    # Allow the user to log in as root without a password.
    nixos = {
      pkgs,
      config,
      ...
    }: {
      users.users.root.initialHashedPassword = "";

      # Don't require sudo/root to `reboot` or `poweroff`.
      security.polkit.enable = true;

      # Allow passwordless sudo from nixos user
      security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
      };

      # Automatically log in at the virtual consoles.
      services.getty.autologinUser = "admin";

      # We run sshd by default. Login is only possible after adding a
      # password via "passwd" or by adding a ssh key to ~/.ssh/authorized_keys.
      # The latter one is particular useful if keys are manually added to
      # installation device for head-less systems i.e. arm boards by manually
      # mounting the storage in a different system.
      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "yes";
      };

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE67zi95Ni36JuP9QLqM0WhRwXHkhoZsjSsKnjraBSX8"
      ];
      # allow nix-copy to live system
      nix.settings.trusted-users = ["admin"];

      # We are stateless, so just default to latest.
      system.stateVersion = config.system.nixos.release;

      networking.useNetworkd = true;
      # mdns
      networking.firewall.allowedUDPPorts = [5353];
      systemd.network.networks = {
        "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
        "99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";
      };

      # This comment was lifted from `srvos`
      # Do not take down the network for too long when upgrading,
      # This also prevents failures of services that are restarted instead of stopped.
      # It will use `systemctl restart` rather than stopping it with `systemctl stop`
      # followed by a delayed `systemctl start`.
      systemd.services = {
        systemd-networkd.stopIfChanged = false;
        # Services that are only restarted might be not able to resolve when resolved is stopped before
        systemd-resolved.stopIfChanged = false;
      };

      # Use iwd instead of wpa_supplicant. It has a user friendly CLI
      networking.wireless.enable = false;
      networking.wireless.iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
          Settings.AutoConnect = true;
        };
      };
    };
  };
  den.aspects.raspi = {aspects, ...}: {
    nixos = {pkgs, ...}: {
      imports = with inputs.nixos-raspberrypi.nixosModules; [
        # Required: Add necessary overlays with kernel, firmware, vendor packages
        nixos-raspberrypi.lib.inject-overlays

        raspberry-pi-4.bluetooth
        raspberry-pi-4.base
        common-user-config
        usb-gadget-ethernet # Configures USB Gadget/Ethernet - Ethernet emulation over USB
        # Binary cache with prebuilt packages for the currently locked `nixpkgs`,
        # see `devshells/nix-build-to-cachix.nix` for a list
        trusted-nix-caches

        # Optional: All RPi and RPi-optimised packages to be available in `pkgs.rpi`
        nixpkgs-rpi

        # Optonal: add overlays with optimised packages into the global scope
        # provides: ffmpeg_{4,6,7}, kodi, libcamera, vlc, etc.
        # This overlay may cause lots of rebuilds (however many
        #  packages should be available from the binary cache)

        # nixos-raspberrypi.lib.inject-overlays-global
      ];
    };
  };
}
