{ pkgs, ... }:
{
  services."app".service = {
    image = "nextcloud";
    restart = "always";
    ports = [ "8081:80" ];
    volumes = [ "/var/lib/data/nc:/var/www/html" ];
  };
}
