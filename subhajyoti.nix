{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.niri.homeModules.config
  ];

  home.username = "delllaptop";
  home.homeDirectory = "/home/delllaptop";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.niri = {
    config = builtins.readFile ./config/niri/config.kdl;
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

  niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };
}
