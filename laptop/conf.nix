{
  config,
  pkgs,
  ...
}: {
  system.stateVersion = "24.11"; # Did you read the comment?
  networking.hostName = "nixLaptop"; # Define your hostname.

  home-manager.users.xelix = ./home.nix;
}
