{ pkgs, ... }:
{
  project.name = "hass";
  services = {
    "hass".service = {
      image = "ghcr.io/home-assistant/home-assistant:rc";
      restart = "always";
      volumes = [
        "/var/lib/data/hass:/config"
        "/run/dbus:/run/dbus:ro"
        "/etc/localtime:/etc/localtime:ro"
      ];
      privileged = true;
      network_mode = "host";
    };
    "matter".service = {
      image = "ghcr.io/home-assistant-libs/python-matter-server:stable";
      restart = "always";
      volumes = [
        "/var/lib/data/hass-matter:/data"
        "/run/dbus:/run/dbus:ro"
      ];
      network_mode = "host";
    };
  };
}
