{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default = {
            enableUpdateCheck = false;
            enableExtensionUpdateCheck = false;

            userSettings = {
            };

            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
            ] ++ (with pkgs.nix-vscode-extensions.open-vsx; [
                continue.continue
                asciidoctor.asciidoctor-vscode
            ]);
        };
    };
}
