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
