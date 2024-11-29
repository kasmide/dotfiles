{ pkgs, ... }:
{
  project.name = "hass";
  services = {
    "hass".service = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      restart = "always";
      volumes = [
        "/var/lib/data/hass:/config"
        "/run/dbus:/run/dbus:ro"
        "/etc/localtime:/etc/localtime:ro"
      ];
      privileged = true;
      network_mode = "host";
    };
  };
}
