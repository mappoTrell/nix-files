{eg, ...}: {
  eg.vm.provides = {
    gui.includes = [
      eg.vm
      eg.vm-bootable._.gui
      eg.laptop
    ];

    tui.includes = [
      eg.vm
      eg.vm-bootable._.tui
      # eg.niri
    ];
  };
}
