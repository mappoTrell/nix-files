{
  eg,
  den,
  __findFile,
  ...
}: {
  eg.system = den.lib.parametric.atLeast {
    includes = [
      # <eg/niri>
      eg.niri
      eg.ghostty
      <eg/qutebrowser>
      eg.nh
      <eg/dev/direnv>
      # eg._.niri
    ];
  };
}
