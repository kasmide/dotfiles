# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "ip=192.168.1.2::192.168.0.1:255.255.254.0:Mini:enp1s0:none" "ip=none" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd = {
    availableKernelModules = [ "r8169" ];
    systemd.enable = true;
    # systemd.users.root.shell = "${pkgs.systemd}/bin/systemd-tty-ask-password-agent";
    network = {
      enable = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLvewPTuiXVAZxHoPmO5L2BUPFk6DQcsgiOe104ALss tomhi"
        ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
    };
  };

  networking = {
    hostName = "Mini"; # Define your hostname.
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    interfaces.enp1s0 = {
      ipv4.addresses = [{
      	address = "192.168.1.2";
      	prefixLength = 23;
      }];
      wakeOnLan.enable = true;
    };
    defaultGateway = {
      address = "192.168.0.1";
      interface = "enp1s0";
    };
    firewall = {
      # interfaces."enp1s0" = {
      #   allowedTCPPorts = [ 22 80 ];
      # };
      trustedInterfaces = [ "tailscale0" "enp1s0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      allowPing = true;
    };
    timeServers = [ "ntp.nict.jp" ];
  };
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "jp";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "jp";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # home-manager.users.tomhi = { pkgs, ... }: {
  #   /* The home.stateVersion option does not have a default and must be set */
  #   home.stateVersion = "24.05";
  #   /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  # };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomhi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      vim
      git
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLvewPTuiXVAZxHoPmO5L2BUPFk6DQcsgiOe104ALss tomhi"
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  systemd = {
    services = {
      "nextcloud-cronjob" = {
        serviceConfig = {
          ExecCondition = "${pkgs.docker}/bin/docker exec --user www-data nextcloud php /var/www/html/occ status -e";
          ExecStart = "${pkgs.docker}/bin/docker exec --user www-data nextcloud php /var/www/html/cron.php";
          KillMode = "process";
        };
      };
    };
    timers = {
      "nextcloud-cronjob-timer" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "5m";
          Unit = "nextcloud-cronjob.service";
        };
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
    };
  };

  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/tomhi/Syncthing";
    user = "tomhi";
    settings = {
      devices = {
        "Arch-Desktop" = { id = "Y4XH6XI-K3VSJVC-TLIZ6YR-TCPDEAK-TKTYYI4-XTDD6FE-T26FLFS-YHDBUAB"; };
        "Pixel-7" = { id = "RZ5TYSR-6B7IHGR-IBJFVAC-AT2RS3T-LMFNHML-36NQDGJ-MN6UMVU-BECUPQ4"; };
        "SurfaceProArch" = { id = "7RN5FFY-LQ72ZC3-F2KRQ5N-JDQDWQL-F2VRRDZ-HS4RBOE-PUSE567-XI3MEQD"; };
        "SOG01" = { id = "N4CXOJK-CGW6KFR-BQ6Z2ZE-DVDCRZ5-GXGH6A7-7NNPDD4-WS543E7-6Y5FSQD"; };
      };
      folders = {
        "KeePass" = {
          id = "pnn2n-ugpky";
          devices = [ "Arch-Desktop" "Pixel-7" "SurfaceProArch" "SOG01" ];
          path = "/home/tomhi/Syncthing/KeePass";
        };
        "Syncthing" = {
          id = "kgntc-zskvx";
          devices = [ "Arch-Desktop" "Pixel-7" "SurfaceProArch" "SOG01" ];
          path = "/home/tomhi/Syncthing/Syncthing";
          ignorePerms = false;
        };
        "Data" = {
          id = "vx7do-vxvdj";
          devices = [ "Arch-Desktop" "Pixel-7" "SOG01" ];
          path = "/home/tomhi/Syncthing/Data";
          ignorePerms = false;
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; 

  services.nginx = {
    enable = true;
    clientMaxBodySize = "0";
    virtualHosts = {
      "*:80 *:443" = {
        serverName = "mini";
        locations = {
          "/nextcloud/" = {
            proxyPass = "http://localhost:8081/";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
          "/git/" = {
            proxyPass = "http://localhost:8082/";
          };
        };
        root = "/var/lib/data/static";
      };
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "2d794253-7dc0-49c3-8257-da883e8d5bc3" = {
        credentialsFile = "/etc/cloudflared/2d794253-7dc0-49c3-8257-da883e8d5bc3.json";
        default = "http_status:403";
      };
    };
  };
  # services.cockpit = {
  #   enable = true;
  #   openFirewall = true;
  # };

  virtualisation.arion = {
    backend = "docker";
    projects = {
      "nextcloud".settings = {
        imports = [ ./arion-nextcloud.nix ];
      };
      # "gitlab".settings = {
      #   imports = [ ./arion-gitlab.nix ];
      # };
      "gitea".settings = {
        imports = [ ./arion-gitea.nix ];
      };
      "hass".settings = {
        imports = [ ./arion-hass.nix ];
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

