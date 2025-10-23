{
  description = "Home Manager configuration, xremap part";

  inputs = {
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { xremap-flake, ... }: {
    homeManagerModules.default = {
      imports = [
        xremap-flake.homeManagerModules.default {
            services.xremap = {
                enable = true;
                withKDE = true;
                watch = true;
                config.modmap = [{
                    name = "Global";
                    remap = {
                      "Henkan" = "Shift_L";
                      "CapsLock" = "Ctrl_L";
                    };
                }];
            };
        }
      ];
    };
  };
}
