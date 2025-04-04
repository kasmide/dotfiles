{ pkgs, ... }:
{
  project.name = "nextcloud";
  services = {
    "app".service = {
      image = "nextcloud";
      container_name = "nextcloud";
      restart = "always";
      ports = [ "8081:80" ];
      volumes = [ "/var/lib/data/nc:/var/www/html" ];
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
