{ pkgs, ... }:
{
  project.name = "gitea";
  services = {
    "gitea".service = {
      image = "codeberg.org/forgejo/forgejo:11";
      restart = "always";
      ports = [ "8082:3000" "2222:22" ];
      environment = {
        USER_UID = "1000";
        USER_GID = "1000";
      };
      volumes = [
        "/var/lib/data/gitea:/data"
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
      ];
    };
  };
}
