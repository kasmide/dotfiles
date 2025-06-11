{ config, pkgs, lib, ... }:

{
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "firefox-devedition-bin"
        "firefox-developer-edition-bin-unwrapped"
    ];
    home.packages = with pkgs; [
        keepassxc
        kdePackages.yakuake
        firefox-devedition-bin
        vlc
        loupe
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        mplus-outline-fonts.githubRelease
        hack-font
        kdePackages.oxygen-sounds
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
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-skk
            fcitx5-mozc
            fcitx5-chinese-addons
        ];
    };
    xdg.autostart = {
        enable = true;
        entries = [ "${pkgs.kdePackages.yakuake}/bin/yakuake" ];
    };
}
