{
  eg,
  den,
  __findFile,
  ...
}: {
  eg.laptop = den.lib.parametric.atLeast {
    includes = [
      # <eg/niri>
      eg.niri
    ];
  };
}
