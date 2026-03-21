{
  eg.gaming = {
    user,
    host,
    # pkgs,
    ...
  }: {
    nixos = {pkgs, ...}: {
      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;

          env = {
            DXVK_HDR = "1";
          };
          args = let
            rt =
              if host.name == "nixos"
              then "--rt"
              else "";
          in [
            "--hdr-enabled"
            "--adaptive-sync"
            "-r 144"
            rt
            "--hdr-itm-enable"
            "--steam"
          ];
        };
        steam = {
          gamescopeSession.enable = true;
          enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        gamescope-wsi # HDR won't work without this
      ];
    };
  };
}
