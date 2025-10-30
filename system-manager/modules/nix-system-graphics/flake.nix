{
  description = "System Manager configuration, nix-system-graphics part";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-system-graphics }: 
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      systemConfigs.ArchOmni = {
        imports = [
          nix-system-graphics.systemModules.default {
            config = {
              system-graphics = {
                enable = true;
                extraPackages = with pkgs; [
                  vpl-gpu-rt
                  intel-media-driver
                  libvdpau-va-gl
                ];
              };
            };
          }
        ];
      };
    };
}