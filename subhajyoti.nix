{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  home.username = "delllaptop";
  home.homeDirectory = "/home/delllaptop";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };

  programs.niri = {
    package = pkgs.niri-unstable;
    config = builtins.readFile ./config/niri/config.kdl;
  };

  xdg.configFile = {
    "DankMaterialShell/settings.json".source =
      ./config/dms/settings.json;

    "DankMaterialShell/plugin_settings.json".source =
      ./config/dms/plugin_settings.json;

    "matugen".source =
      ./config/matugen;

    "qt5ct/qt5ct.conf".source =
      ./config/qt5ct/qt5ct.conf;

    "qt6ct/qt6ct.conf".source =
      ./config/qt6ct/qt6ct.conf;

    "niri/piri.toml".source =
      ./config/piri/piri.toml;
  };

  qt = {
    enable = true;

  platformTheme = {
    name = "qtct";
    package = pkgs.qt6Packages.qt6ct;
   };
};

  home.packages = with pkgs; [
    qt6Packages.qt6ct
    libsForQt5.qt5ct
  ];
}
