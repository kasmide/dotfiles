{ pkgs, ... }:

{
  systemd.user.services.rclone-serve = {
    Unit = {
      Description = "Rclone serve service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.rclone}/bin/rclone serve webdav --addr :8084 --htpasswd /var/lib/data/tomhi/htpasswd /var/lib/data/tomhi/files/";
      Restart = "always";
    };
  };
}
