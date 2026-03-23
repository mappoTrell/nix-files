{
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.flake-file.url = lib.mkDefault "github:vic/flake-file/latest";
  flake-file.inputs.den.url = lib.mkDefault "github:vic/den/latest";
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];
}
