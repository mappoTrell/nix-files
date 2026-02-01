{ inputs, den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;
  imports = [
    (inputs.den.namespace "my" false)
    (inputs.den.namespace "xelix" false) 
    (inputs.den.namespace "shared" true)
  ];
}