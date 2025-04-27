{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        keepassxc
        yakuake
        firefox-devedition-bin
        vlc
        loupe
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        mplus-outline-fonts.githubRelease
        hack-font
    ];
    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ "Hack" ];
            sansSerif = [ "Noto Sans" "M PLUS 1" "Noto Sans CJK JP" ];
        };
    };
    services.kdeconnect = {
        enable = true;
        package = pkgs.kdePackages.kdeconnect-kde;
    };
    i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-skk
            fcitx5-mozc
            fcitx5-chinese-addons
        ];
    };
}
