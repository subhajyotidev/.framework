{ lib, ... }:

{
  flake.modules.homeManager.options-applications =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.applications.enable = lib.mkEnableOption "desktop applications";

      config = lib.mkIf config.applications.enable {
        home.packages = with pkgs; [
          pear-desktop
          bitwarden-desktop
          blender
          sioyek
          wlr-which-key
          libreoffice
          davinci-resolve
          kdePackages.dolphin
          scrcpy
        ];
      };
    };
}
