{ inputs, self, ... }:

{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
    };

    modules = [
      # Reusable feature modules
      self.modules.nixos.boot
      self.modules.nixos.system-base
      self.modules.nixos.nix-tools
      self.modules.nixos.system-services
      self.modules.nixos.piri
      self.modules.nixos.user-account
      self.modules.nixos.system-packages
      self.modules.nixos.system-programs
      self.modules.nixos.options-packaging
      self.modules.nixos.options-containers'
      self.modules.nixos.options-networking'
      self.modules.nixos.options-graphics
      self.modules.nixos.options-gaming
      self.modules.nixos.options-virtualisation'
      self.modules.nixos.options-media
      self.modules.nixos.options-trustedSubstituters
      self.modules.nixos.options-desktop

      # Machine-specific hardware configuration
      self.modules.nixos.hardware

      # Shared custom package overlay
      self.modules.nixos.custom-overlay

      # Custom DAW packages
      self.modules.nixos.daw-overlay

      # Host-specific feature selection
      {
        packaging = {
          flatpak.enable = true;
          appimage.enable = true;
        };

        trustedSubstituters.enable = true;

        desktop.niri.enable = true;

        media = {
          enable = true;

          bluetooth.enable = true;

          routing.enable = true;

          optimizations.enable = true;
        };

        virtualisation' = {
          qemu = {
            enable = true;
            runAsRoot = true;

            guest.enable = false;
            manager.enable = true;
          };

          waydroid.enable = true;
        };

        containers' = {
          enable = true;

          autoPrune = {
            enable = true;
            dates = "weekly";
          };
        };

        graphics = {
          enable = true;

          nvidia = {
            enable = true;

            prime = {
              enable = true;

              settings = {
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";

                offload = {
                  enable = true;
                  enableOffloadCmd = true;
                };
              };
            };

            containerToolkit.enable = false;
          };
        };

        gaming = {
          steam.enable = true;
          gamescope.enable = true;
          gamemode.enable = true;
        };

        networking' = {
          enable = true;
          name = "nixos";

          manager.enable = true;

          openssh = {
            enable = true;
            ports = [ 54321 ];

            settings = {
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
              PermitRootLogin = "no";
              AllowUsers = [ "delllaptop" ];
            };

            endlessh.port = 22;
          };

          allowedPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];

          openvpn.enable = true;
          wireshark.enable = true;
        };
      }
    ];
  };
}
