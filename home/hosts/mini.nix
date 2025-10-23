{ pkgs, ... }:

{
  # mini host specific configuration
  systemd.user.services.rclone-serve = {
    Unit = {
      Description = "Rclone serve service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.rclone}/bin/rclone serve webdav --addr :8084 --htpasswd /var/lib/data/tomhi/htpasswd --dir-cache-time 1s -L /var/lib/data/tomhi/files/";
      Restart = "always";
    };
  };
}
