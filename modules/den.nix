{
  den,
  lib,
  ...
}: let
  conf = {
    shell = "fish";
    theme = "rose-pine";
    # classes = ["homeManager"];
  };
in {
  den.hosts.x86_64-linux.nixos.users.xelix = {
    inherit conf;
  };
  den.hosts.x86_64-linux.nixLaptop.users.xelix = {
    inherit conf;
  };

  den.hosts.aarch64-linux.raspi.users.admin = {};

  den.schema.user.classes = lib.mkDefault ["homeManager"];
  # den.ctx.user.includes = [den._.mutual-provider];
}
