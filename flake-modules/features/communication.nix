{ lib, ... }:

{
  flake.modules.homeManager.options-communication =
    { config, ... }:
    {
      options.communication.vesktop.enable = lib.mkEnableOption "enable Vesktop";

      config = lib.mkIf config.communication.vesktop.enable {
        programs.vesktop.enable = true;
      };
    };
}
