{ pkgs, ... }:
{
  project.name = "nextcloud";
  services."app".service = {
    image = "nextcloud";
    container_name = "nextcloud";
    restart = "always";
    ports = [ "8081:80" ];
    volumes = [ "/var/lib/data/nc:/var/www/html" ];
  };
}
