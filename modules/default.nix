{ __findFile, ... }:
{
  imports = [
    ./dendritic.nix
    ./namespace.nix
    ./my
    ./xelix  
    ./shared
  ];
}