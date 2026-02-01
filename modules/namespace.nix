{ inputs, den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;
  den.default.includes = [
    <den/define-user>
    <my/nix-settings>
    <my/state-version>
  ];
  imports = [
    (inputs.den.namespace "my" false)
    (inputs.den.namespace "xelix" false) 
    (inputs.den.namespace "shared" true)
    ./home-manager.nix
  ];
}