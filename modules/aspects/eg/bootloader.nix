{eg, ...}: {
  eg.bootloader.nixos = {pkgs, ...}: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.memtest86.enable = true;
    boot.binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];
  };
}
