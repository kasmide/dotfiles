{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    xremap-config.url = "path:../xremap";
  };

  outputs = { nixpkgs, home-manager, nix-vscode-extensions, xremap-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-vscode-extensions.overlays.default ];
      };
    in {
      homeConfigurations.tomhi = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./custom.nix ../home.nix xremap-config.homeManagerModules.default ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
