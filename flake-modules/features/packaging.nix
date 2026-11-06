{ inputs, ... }:

{
  # NixOS packaging configuration
  flake.modules.nixos.options-packaging =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options.packaging = lib.mkOption {
        type = lib.types.submodule {
          options = {
            flatpak.enable = lib.mkEnableOption "enable Flatpak";

            appimage.enable = lib.mkEnableOption "enable AppImage with sane defaults";
          };
        };

        default = { };
      };

      config = lib.mkMerge [
        (lib.mkIf config.packaging.flatpak.enable {
          services.flatpak.enable = true;
        })

        (lib.mkIf config.packaging.appimage.enable {
          programs.appimage = {
            enable = true;
            binfmt = true;

            package = pkgs.appimage-run.override {
              extraPkgs = pkgs: [
                pkgs.libxcrypt
                pkgs.icu
              ];
            };
          };
        })
      ];
    };

  # Home Manager packaging configuration
  flake.modules.homeManager.options-packaging =
    { config, lib, ... }:
    {
      imports = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];

      options.homePackaging = lib.mkOption {
        type = lib.types.submodule {
          options.flatpak.enable = lib.mkEnableOption "enable Home Manager Flatpak";
        };

        default = { };
      };

      config = lib.mkIf config.homePackaging.flatpak.enable {
        services.flatpak = {
          enable = true;

          remotes = [
            {
              name = "flathub";
              location = "https://flathub.org/repo/flathub.flatpakrepo";
            }
          ];

          packages = [
            "com.github.tchx84.Flatseal"
            "io.github.flattool.Warehouse"
            "com.usebottles.bottles"
          ];

          update.auto.enable = true;
          update.auto.onCalendar = "daily";
        };
      };
    };
}
