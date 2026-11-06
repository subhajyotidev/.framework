{
  inputs,
  lib,
  moduleWithSystem,
  ...
}:

{
  flake.modules.homeManager.options-desktop = moduleWithSystem (
    { system, ... }:

    { config, pkgs, ... }:
    let
      pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in

    {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
      ];

      config = lib.mkIf (config.desktop.niri.enable && config.desktop.niri.dms.enable) {
        programs.dank-material-shell = {
          enable = true;
          enableSystemMonitoring = true;

          # Build DMS and its Qt dependencies using nixpkgs-unstable
          package = inputs.dms.lib.mkDmsShell pkgsUnstable;

          # Use the matching Quickshell version
          quickshell.package = pkgsUnstable.quickshell;

          settings = builtins.fromJSON (builtins.readFile ../../../config/dms/settings.json);

          niri = {
            enableKeybinds = false;
            enableSpawn = true;
          };

          plugins = {
            batteryPlus = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "batteryPlus";
                rev = "4e653d09174e1edc260f279c42ec2477b6fb2e24";
                hash = "sha256-XEAvnTisFTPs55+uVCDeHXSJthtkE0CU6No29TDyAYY=";
              };
            };

            calculator = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "calculator";
                rev = "1db5865419a40a33171a475855a59e0b8bf7187f";
                hash = "sha256-j8C62+sevr6b+akzVSAqUVysIhb6Vbr8jnWcTXeOtE8=";
              };
            };

            clipboardPlus = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "clipboardPlus";
                rev = "46405816d7e69af59026d10447c93262c645296c";
                hash = "sha256-7B7zyzOQ4vjWjyZv8dAHy+ViT3SjsbcLMO1Y9NFvHxs=";
              };
            };

            commandRunner = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "commandRunner";
                rev = "35277695de06beadaba701cb94cc8b096b233319";
                hash = "sha256-o43IyVT901ZzZGDvZKWhlrgMba57thAoqL3+BFaFV74=";
              };
            };

            dockerManager = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dockerManager";
                rev = "255f46794b6e3a5f5e842fe1330db3869deddc09";
                hash = "sha256-YDCwXF0dyuNy07voKvkLlKfHFfPkhSS4oGopn+EnM+0=";
              };
            };

            emojiLauncher = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "emojiLauncher";
                rev = "1c0a7d337a52b48f9499060076703a35e8dd4f4f";
                hash = "sha256-NQ14YenDiNK2VqXQ3z7jAkatbSRtYJHhOhvv7AJlUD8=";
              };
            };

            niriWindows = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "niriWindows";
                rev = "f2c0b0fc0325e3299257cc5d1895069a3d49247f";
                hash = "sha256-uKNiqr/DiX28dePBqsEfBPaCB/kmVDzjayXHdIwGkZQ=";
              };
            };

            wallpaperCarousel = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "wallpaperCarousel";
                rev = "c08fbb92c39d4d778bb08e520cfd96e395594440";
                hash = "sha256-t70CBhiEBYHa9HvPpCZnfA8eCOWhUlXc6SUa9VprFNE=";
              };
            };

            webSearch = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "webSearch";
                rev = "8ec42a2dff96b94cdd0d40b57c1acd815c15079a";
                hash = "sha256-S1A50s7cKE0NuidC+x589wIxqGA6JW8GrCVEkCddMQs=";
              };
            };

            DankHooks = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dms-plugins";
                rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
                hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
                sparseCheckout = [ "DankHooks" ];
              };
            };

            DankKDEConnect = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dms-plugins";
                rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
                hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
                sparseCheckout = [ "DankKDEConnect" ];
              };
            };

            DankNotepadModule = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dms-plugins";
                rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
                hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
                sparseCheckout = [ "DankNotepadModule" ];
              };
            };

            dankPinentry = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dankPinentry";
                rev = "02df8bceb651bdbc5fdc7a07b5f6f19e60c3906a";
                hash = "sha256-vyDIpTClqE1UheULRdVzg2XOr1BEhN+mWJPkMbn3V2g=";
                sparseCheckout = [ "plugin" ];
              };
            };

            ClipboardPlus = {
              src = pkgs.fetchFromGitHub {
                owner = "debarchito";
                repo = "dadan-dms-plugins";
                rev = "63fe6b87c497f1f7c2ea61432716817db1c5c3a4";
                hash = "sha256-m4XMKkBK8cxl3nj5J/2tbwU9hbO/Qu6Xo6SEcprFG1Q=";
                sparseCheckout = [ "ClipboardPlus" ];
              };
            };
          };
        };

        xdg.configFile = {
          "DankMaterialShell/settings.json".source = ../../../config/dms/settings.json;

          "matugen".source = ../../../config/matugen;

          "qt5ct/qt5ct.conf".source = ../../../config/qt5ct/qt5ct.conf;

          "qt6ct/qt6ct.conf".source = ../../../config/qt6ct/qt6ct.conf;

          "niri/piri.toml".source = ../../../config/piri/piri.toml;

          "matugen/templates/kitty/dankcolors.conf".source =
            ../../../config/matugen/templates/kitty/dankcolors.conf;

          "matugen/templates/fish/dankcolors.fish".source =
            ../../../config/matugen/templates/fish/dankcolors.fish;
        };
      };
    }
  );
}
