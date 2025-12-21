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
    home.sessionVariables = {
        QT_ENABLE_HIGHDPI_SCALING = "1";
    };
}