{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        keepassxc
        kdePackages.ark
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        kdePackages.ffmpegthumbs
        kdePackages.gwenview
        kdePackages.kate
        kdePackages.kded
        kdePackages.kleopatra
        kdePackages.konsole
        kdePackages.okular
        kdePackages.plasma-browser-integration
        kdePackages.spectacle
        kdePackages.yakuake
        kdePackages.oxygen-sounds
        mission-center
        vlc
        spotify
        libreoffice-fresh
        loupe
        lxqt.lximage-qt
        wl-clipboard
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
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
        platformTheme.name = "kde";
    };
    fonts.fontconfig = {
        enable = true;
        antialiasing = true;
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
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-devedition;
        languagePacks = [ "ja" ];
        nativeMessagingHosts = [
            pkgs.kdePackages.plasma-browser-integration
        ];
    };
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-skk
            fcitx5-mozc
            qt6Packages.fcitx5-chinese-addons
            qt6Packages.fcitx5-configtool
            fcitx5-gtk
        ];
    };
    xdg.autostart = {
        enable = true;
        entries = [ "${pkgs.kdePackages.yakuake}/bin/yakuake" ];
    };
    home.sessionVariables = {
        QT_ENABLE_HIGHDPI_SCALING = "1";
    };
}
