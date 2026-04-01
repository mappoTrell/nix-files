{
  den,
  eg,
  __findFile,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixos-router = {
      url = "github:chayleaf/nixos-router";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";

      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };
  };

  den.hosts.aarch64-linux.raspi = {
    instantiate = inputs.nixos-raspberrypi.lib.nixosSystem;
    users.admin = {
      # classes = [];
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

      fileSystems = {
        "/boot/firmware" = {
          device = "/dev/disk/by-label/FIRMWARE";
          fsType = "vfat";
          options = [
            "noatime"
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=1min"
          ];
        };
        "/" = {
          device = "/dev/disk/by-label/NIXOS_SD";
          fsType = "ext4";
          options = ["noatime"];
        };
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
      # # mdns
      # networking.firewall.allowedUDPPorts = [5353];
      # systemd.network.networks = {
      #   "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
      #   "99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";
      # };

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
      # networking.wireless.enable = false;
      # networking.wireless.iwd = {
      #   enable = true;
      #   settings = {
      #     Network = {
      #       EnableIPv6 = true;
      #       RoutePriorityOffset = 300;
      #     };
      #     Settings.AutoConnect = true;
      #   };
      # };
    };
  };
  den.aspects.raspi =
    #{aspects, ...}:
    {
      nixos = {
        pkgs,
        self',
        ...
      }: let
        lanIf = "end0";
        wanIf = "enp1s0u1";
      in {
        imports =
          [
            inputs.nixos-router.nixosModules.default
          ]
          ++ (with inputs.nixos-raspberrypi; [
            lib.inject-overlays
            nixosModules.raspberry-pi-4.base
            nixosModules.usb-gadget-ethernet
            nixosModules.nixpkgs-rpi
          ]);

        router.enable = true;

        router.interfaces = {
          ${lanIf} = {
            ipv4 = {
              enableForwarding = true;
              addresses = [
                {
                  address = "192.168.1.1";
                  prefixLength = 24;
                }
              ];
              kea = {
                enable = true;
                settings = {
                  option-data = [
                    {
                      name = "domain-name-servers";
                      data = "1.1.1.1";
                    }
                  ];
                };
              };
            };
          };
          ${wanIf} = {
            ipv4 = {
              enableForwarding = true;
            };
            dhcpcd.enable = true;
          };
        };

        router.networkNamespaces = {
          default = {
            nftables.textRules = ''
              table ip nat {
                chain postrouting {
                  type nat hook postrouting priority 100; policy accept;
                  oifname "${wanIf}" masquerade
                }
              }
            '';
          };
        };

        services.resolved.enable = true;

        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE67zi95Ni36JuP9QLqM0WhRwXHkhoZsjSsKnjraBSX8"
        ];

        environment.systemPackages = with pkgs; [
          tree
          hello
        ];

        services.openssh.enable = true;

        hardware.enableRedistributableFirmware = true;

        nix.settings.experimental-features = ["nix-command" "flakes"];
      };
    };
}
