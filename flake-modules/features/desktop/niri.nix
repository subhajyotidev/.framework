{ inputs, lib, ... }:

{
  # NixOS Niri integration
  flake.modules.nixos.options-desktop =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      config = lib.mkIf config.desktop.niri.enable {
        nixpkgs.overlays = [
          inputs.niri.overlays.niri
        ];

        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
      };
    };

  # Home Manager Niri integration
  flake.modules.homeManager.options-desktop =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.niri.homeModules.niri
      ];

      config = lib.mkIf config.desktop.niri.enable {
        programs.niri = {
          package = pkgs.niri-unstable;

          settings.layout.border.enable = false;

          config = builtins.readFile ../../../config/niri/config.kdl;
        };
      };
    };
}
