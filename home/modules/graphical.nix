{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        keepassxc
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        kdePackages.kate
        kdePackages.konsole
        kdePackages.yakuake
        kdePackages.oxygen-sounds
        firefox-devedition
        vlc
        loupe
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        mplus-outline-fonts.githubRelease
        hack-font
    ];
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.kdePackages.breeze;
        name = "Breeze Light";
    };
    qt = {
        enable = true;
        style.name = "Breeze";
    };
    fonts.fontconfig = {
        enable = true;
        antialiasing = false;
        hinting = "slight";
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
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-skk
            fcitx5-mozc
            fcitx5-chinese-addons
            fcitx5-configtool
            fcitx5-gtk
            kdePackages.fcitx5-qt
            libsForQt5.fcitx5-qt
        ];
    };
    xdg.autostart = {
        enable = true;
        entries = [ "${pkgs.kdePackages.yakuake}/bin/yakuake" ];
    };
}
