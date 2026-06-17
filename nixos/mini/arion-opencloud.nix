{ pkgs, ... }:
{
  project.name = "opencloud";
  services = {
    "app".service = {
      image = "opencloudeu/opencloud-rolling:latest";
      restart = "always";
      ports = [ "8085:9200" ];
      volumes = [
        "/var/lib/data/opencloud/data:/var/lib/opencloud"
        "/var/lib/data/opencloud/config:/etc/opencloud"
      ];
      environment = {
        OC_INSECURE = "true";
        PROXY_TLS = "false";
        OC_URL = "https://ocl.1e2.at";
      };
    };
  };
}
