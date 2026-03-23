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
