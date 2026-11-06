{
  flake.modules.nixos.options-media =
    {
      inputs,
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.musnix.nixosModules.musnix
      ];

      options.media = lib.mkOption {
        type = lib.types.submodule {
          options = {
            enable = lib.mkEnableOption "enable the media stack";

            bluetooth.enable = lib.mkEnableOption "enable the bluetooth stack";

            routing.enable = lib.mkEnableOption "add tools that aid in media routing";

            optimizations.enable = lib.mkEnableOption "enable useful optimizations for realtime and low latency work";

            streaming = {
              client.enable = lib.mkEnableOption "enable moonlight";

              server = {
                enable = lib.mkEnableOption "enable sunshine for streaming";

                autostart = lib.mkEnableOption "enable sunshine server automatically";
              };
            };
          };
        };

        default = { };
      };

      config = lib.mkIf config.media.enable (
        lib.mkMerge [
          # Core audio stack
          {
            services.pipewire = {
              enable = true;

              alsa = {
                enable = true;
                support32Bit = true;
              };

              pulse.enable = true;
              jack.enable = true;
              wireplumber.enable = true;
            };
          }

          # Bluetooth
          (lib.mkIf config.media.bluetooth.enable {
            hardware.bluetooth.enable = true;
          })

          # Audio routing tools
          (lib.mkIf config.media.routing.enable {
            environment.systemPackages = [
              pkgs.qpwgraph
            ];
          })

          # Low-latency audio optimizations
          (lib.mkIf config.media.optimizations.enable {
            musnix = {
              enable = true;
              rtcqs.enable = true;

              kernel.packages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
            };

            services.pipewire.extraConfig.jack = {
              "10-clock-rate" = {
                "jack.properties" = {
                  "node.latency" = "128/48000";
                  "node.rate" = "1/48000";
                  "node.lock-quantum" = true;
                };
              };
            };
          })

          # Sunshine streaming server
          (lib.mkIf config.media.streaming.server.enable {
            services.sunshine = {
              enable = true;
              autoStart = config.media.streaming.server.autostart;
              capSysAdmin = true;
              openFirewall = true;
            };
          })

          # Moonlight streaming client
          (lib.mkIf config.media.streaming.client.enable {
            environment.systemPackages = [
              pkgs.moonlight-qt
            ];
          })
        ]
      );
    };

  # Home Manager media configuration
  flake.modules.homeManager.options-media =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.media.obs.enable = lib.mkEnableOption "enable OBS Studio and its plugins";

      config = lib.mkIf config.media.obs.enable {
        programs.obs-studio = {
          enable = true;

          plugins = [
            pkgs.obs-studio-plugins.obs-pipewire-audio-capture
            pkgs.obs-studio-plugins.obs-vkcapture
          ];
        };
      };
    };
}
