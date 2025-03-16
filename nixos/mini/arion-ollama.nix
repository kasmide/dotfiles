{ pkgs, ... }:
{
  project.name = "ollama";
  services = {
    "ollama".service = {
      image = "ollama/ollama";
      container_name = "ollama";
      restart = "always";
      ports = [ "11434:11434" ];
      volumes = [
        "/var/lib/data/ollama/ollama:/root/.ollama"
      ];
    };
    "webui".service = {
      image = "ghcr.io/open-webui/open-webui:main";
      restart = "always";
      ports = [ "8083:8080" ];
      volumes = [
        "/var/lib/data/ollama/openwebui:/app/backend/data"
      ];
    };
  };
}
