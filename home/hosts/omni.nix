{ pkgs, ... }:

{
  # omni host specific configuration
  targets.genericLinux.enable = true;

  home.packages = [
    pkgs.arion
    pkgs.whois
    pkgs.netcat
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
