{ pkgs, ... }:

{
  # omumbp host specific configuration (macOS)
  home.homeDirectory = "/Users/tomhi";

  services.gpg-agent.pinentry.package = pkgs.pinentry_mac;
}
