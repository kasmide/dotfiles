{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        mplus-outline-fonts.githubRelease
        hack-font
    ];
    fonts.fontconfig = {
        enable = true;
        antialiasing = true;
        hinting = "slight";
        defaultFonts = {
            monospace = [ "Hack" ];
            sansSerif = [ "Noto Sans" "M PLUS 1" "Noto Sans CJK JP" ];
        };
    };
}
