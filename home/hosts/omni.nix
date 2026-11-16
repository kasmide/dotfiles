{ pkgs, ... }:

{
  # omni host specific configuration
  targets.genericLinux.enable = true;

  services.gpg-agent.pinentry.package = pkgs.pinentry-qt;

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
