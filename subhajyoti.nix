{ config, pkgs, inputs, system, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
  ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  home.username = "delllaptop";
  home.homeDirectory = "/home/delllaptop";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.niri = {
    package = pkgs.niri-unstable;
    config = builtins.readFile ./config/niri/config.kdl;
  };

  programs.dank-material-shell = {
    enable = true;
    niri.includes.enable = false;
  };
}

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
    package = pkgs.qt6ct;
  };
};

home.packages = with pkgs; [
  qt6ct
  libsForQt5.qt5ct
];
