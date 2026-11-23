{ lib, ... }:

{
  flake.modules.homeManager.options-cursor =
    { config, pkgs, ... }:
    {
      config = lib.mkIf config.desktop.cursor.enable {
        home.pointerCursor = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 24;

          gtk.enable = true;
          x11.enable = true;
        };

        home.sessionVariables = {
          XCURSOR_THEME = "Bibata-Modern-Classic";
          XCURSOR_SIZE = "24";
        };
      };
    };
}
