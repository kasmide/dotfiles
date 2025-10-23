{
  description = "Home Manager configuration, vscode part";

  inputs = {
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { nix-vscode-extensions, ... }: {
    homeManagerModules.default = { pkgs, ... }: {
      nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;

          userSettings = { };

          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
          ] ++ (with pkgs.nix-vscode-extensions.open-vsx; [
            continue.continue
            asciidoctor.asciidoctor-vscode
          ]);
        };
      };
    };
  };
}
