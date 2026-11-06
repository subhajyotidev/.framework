{
  # NixOS desktop options
  flake.modules.nixos.options-desktop =
    { lib, config, ... }:
    {
      options.desktop = lib.mkOption {
        type = lib.types.submodule {
          options = {
            niri.enable = lib.mkEnableOption "enable Niri";

            labwc.enable = lib.mkEnableOption "enable Labwc";
          };
        };

        default = { };
      };

      config = lib.mkIf config.desktop.labwc.enable {
        programs.labwc.enable = true;
      };

      imports = [
        ../../modules/features/desktop-portals.nix
      ];
    };

  # Home Manager desktop options
  flake.modules.homeManager.options-desktop =
    { lib, config, ... }:
    {
      options.desktop = lib.mkOption {
        type = lib.types.submodule {
          options = {
            niri.enable = lib.mkEnableOption "enable Niri";

            niri.dms.enable = lib.mkEnableOption "enable DankMaterialShell for Niri";

            labwc.dms.enable = lib.mkEnableOption "enable DankMaterialShell for Labwc";

            appearance.enable = lib.mkEnableOption "enable desktop appearance configuration";
          };
        };

        default = { };
      };

      config = lib.mkIf config.desktop.labwc.dms.enable {
        xdg.configFile."labwc/autostart".text = "dms run &";
      };
    };
}
