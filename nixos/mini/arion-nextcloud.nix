{ pkgs, ... }:
let
  phpIni = pkgs.writeText "zz-php2shell.ini" ''
    session.upload_progress.enabled = Off
    session.use_strict_mode = 1
    fatal_error_backtraces = 0
    memory_limit = -1
    post_max_size = 32M
    upload_max_filesize = 30M
    max_input_nesting_level = 16
    max_multipart_body_parts = 100
  '';
  apacheConf = pkgs.writeText "zz-php2shell.conf" ''
    php_admin_flag fatal_error_backtraces off
    php_admin_flag session.upload_progress.enabled off
    php_admin_value memory_limit -1
    php_admin_value post_max_size 32M
    php_admin_value upload_max_filesize 30M
    KeepAlive Off
    MaxConnectionsPerChild 1
  '';
in
{
  project.name = "nextcloud";
  services = {
    "app".service = {
      image = "nextcloud";
      container_name = "nextcloud";
      restart = "always";
      ports = [ "8081:80" ];
      volumes = [
        "/var/lib/data/nc:/var/www/html"
        "${phpIni}:/usr/local/etc/php/conf.d/zz-php2shell.ini:ro"
        "${apacheConf}:/etc/apache2/conf-enabled/zz-php2shell.conf:ro"
      ];
      environment = {
        PHP_MEMORY_LIMIT = "1G";
      };
    };
    "mariadb".service = {
      image = "mariadb";
      restart = "always";
      volumes = [ "/var/lib/data/nc_mariadb:/var/lib/mysql" ];
      environment = {
        MARIADB_RANDOM_ROOT_PASSWORD = "ok";
        MARIADB_AUTO_UPGRADE = "yes please";
      };
    };
  };
}
