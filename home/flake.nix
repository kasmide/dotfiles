{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-config.url = "path:./modules/vscode";
    xremap-config.url = "path:./modules/xremap";
  };

  outputs = { nixpkgs, home-manager, vscode-config, xremap-config, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: {
        homeConfigurations = {
          # Generic multi-architecture configuration
          tomhi = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [ ./modules/common.nix ];
          };

          # mini: x86_64 Linux with graphical environment
          "tomhi@Mini" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              ./modules/common.nix
              ./modules/graphical.nix
              ./hosts/mini.nix
            ];
          };

          # omni: x86_64 Linux with xremap and vscode
          "tomhi@ArchOmni" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              ./modules/common.nix
              ./hosts/omni.nix
              vscode-config.homeManagerModules.default
              xremap-config.homeManagerModules.default
            ];
          };

          # omumbp: macOS (Darwin)
          "tomhi@OMUMBP" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-darwin;
            modules = [
              ./modules/common.nix
              ./hosts/omumbp.nix
            ];
          };
        };
      });
    };
}
