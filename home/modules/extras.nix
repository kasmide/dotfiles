{ pkgs, ... }:

{
  home.packages = with pkgs; [
    asciidoctor-with-extensions
    cargo
    gallery-dl
    go
    yt-dlp
  ];

  programs.claude-code = {
    enable = true;
    mutableSettings = true;
  };
}
