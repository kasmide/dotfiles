{ pkgs, ... }:
let 
  gitlab-home = /var/lib/data/gitlab;
in
{
  services = {
    "gitlab".service = {
      image = "gitlab/gitlab-ce:latest";
      restart = "always";
      ports = [ "8082:80" "2222:22" "8443:443" ];
      environment = {
        GITLAB_OMNIBUS_CONFIG = ''
          # Add any other gitlab.rb configuration here, each on its own line
          external_url 'https://sv.ksmd.dev/git/'
          letsencrypt['enable'] = false
          nginx['listen_port'] = 80
          nginx['listen_https'] = false
        '';
      };
      volumes = [
        "${toString (gitlab-home + /config)}:/etc/gitlab"
        "${toString (gitlab-home + /logs)}:/var/log/gitlab"
        "${toString (gitlab-home + /data)}:/var/opt/gitlab"
      ];
    };
    "runner".service = {
      image = "gitlab/gitlab-runner:latest";
      restart = "always";
      volumes = [
        "${toString (gitlab-home + /runner)}:/etc/gitlab-runner"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };
}
