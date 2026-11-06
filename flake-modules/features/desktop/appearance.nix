{ lib, ... }:

{
  flake.modules.homeManager.options-desktop =
    { config, pkgs, ... }:
    {
      config = lib.mkIf config.desktop.appearance.enable {
        qt = {
          enable = true;

          platformTheme = {
            name = "qtct";
          };
        };

        fonts.fontconfig = {
          enable = true;

          defaultFonts = {
            serif = [ "Lora" ];
            sansSerif = [ "Poppins" ];
            monospace = [ "Maple Mono NF" ];
          };
        };

        gtk = {
          enable = true;

          font = {
            name = "Poppins";
            size = 10;
          };

          gtk3.theme = {
            name = "adw-gtk3";
            package = pkgs.adw-gtk3;
          };

          gtk4.theme = config.gtk.theme;
        };

        home.packages = with pkgs; [
          qt6Packages.qt6ct
          libsForQt5.qt5ct

          lora
          poppins
          maple-mono.NF

          adw-gtk3
          papirus-icon-theme
          papirus-folders
        ];
      };
    };
}
