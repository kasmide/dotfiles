{ config, lib, pkgs, ... }:

{
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set your time zone
  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs.zsh}/bin/zsh";

  home-manager = {
    config = {
      imports = [ ../home/modules/common.nix ];
      home.username = lib.mkForce config.user.userName;
      home.homeDirectory = lib.mkForce config.user.home;
    };
  };
}
