{
  description = "Home Manager configuration, vscode part";

  inputs = {
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { nix-vscode-extensions, ... }: {
    homeManagerModules.default = { pkgs, lib, ... }: {
      nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "vscode-extension-anthropic-claude-code"
        "vscode-extension-github-copilot"
        "vscode-extension-github-copilot-chat"
        "vscode-extension-ms-python-vscode-pylance"
      ];

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;

          userSettings = {
            "github.copilot.nextEditSuggestions.enabled" = true;
            "workbench.colorTheme" = "Quiet Light";
            "editor.formatOnPaste" = true;
            "editor.autoIndentOnPaste" = true;
            "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
            "editor.cursorSmoothCaretAnimation" = "on";
          };

          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
            anthropic.claude-code
            asciidoctor.asciidoctor-vscode
            bbenoist.nix
            github.copilot
            github.copilot-chat
            jakebecker.elixir-ls
            ms-python.debugpy
            ms-python.python
            ms-python.vscode-pylance
            ms-python.vscode-python-envs
            rust-lang.rust-analyzer
            oderwat.indent-rainbow
          ] ++ (with pkgs.nix-vscode-extensions.open-vsx; [
          ]);
        };
      };
    };
  };
}
