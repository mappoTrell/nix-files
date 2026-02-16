{eg, ...}: {
  eg.vm = {
    includes = [];

    nixos = {pkgs, ...}: {
      # VM-specific configuration
      # virtualisation.vmware.guest.enable = true;
      # virtualisation.vmware.host.enable = true;

      # Enable QEMU guest agent for better VM integration
      services.qemuGuest.enable = true;

      # Basic packages for VM
      environment.systemPackages = with pkgs; [
        qemu
      ];
    };
  };

  eg.vm.provides = {
    gui.includes = [
      eg.vm
      eg.vm-bootable._.gui
      eg.xfce-desktop
      # eg.niri
      # eg.laptop
    ];

    tui.includes = [
      eg.vm
      eg.vm-bootable._.tui
      # eg.niri
    ];
  };
}
