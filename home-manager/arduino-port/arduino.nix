{ config, pkgs, inputs,... }:
# let
#   portable = ../arduino-port;
#   ard-portn = pkgs.arduino.overrideAttrs (previousAttrs: {
#   postInstall = (previousAttrs.postInstall or "") + ''
#       cp   ${portable}/test.txt qwertyui.txt
#   '';
# });
# in 
{
  home.packages = [
    (pkgs.arduino.overrideAttrs (finalAttrs: previousAttrs:{
# previousAttrs.installPhase or ""
      installPhase = ("") + ''
        echo "test" > $out/share/arduino/yui.txt
      '';
    }))

  ];
}

