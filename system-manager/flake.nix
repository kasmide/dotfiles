{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "path:./modules/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, system-manager, nix-system-graphics }: {
    systemConfigs.ArchOmni = system-manager.lib.makeSystemConfig {
      modules = [
        {
          config = {
            nixpkgs.hostPlatform = "x86_64-linux";
            system-manager.allowAnyDistro = true;
          };
        }
        nix-system-graphics.systemConfigs.ArchOmni
      ];
    };
  };
}