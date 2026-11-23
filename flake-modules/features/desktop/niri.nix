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
          config = null;
        };

        xdg.configFile."niri/config.kdl".source = ../../../config/niri/config.kdl;
        xdg.configFile.niri-config.enable = lib.mkForce false;
      };
    };
}
